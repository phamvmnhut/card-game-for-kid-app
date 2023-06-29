// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart' hide Level;
import 'package:provider/provider.dart';

import '../ads/ads_controller.dart';
import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../game_internals/level_state.dart';
import '../games_services/games_services.dart';
import '../games_services/score.dart';
import '../in_app_purchase/in_app_purchase.dart';
import '../level_selection/level_selection_screen.dart';
import '../level_selection/levels.dart';
import '../main_menu/main_menu_screen.dart';
import '../player_progress/player_progress.dart';
import '../settings/settings_screen.dart';
import '../style/confetti.dart';
import '../style/palette.dart';

class PlaySessionScreen extends StatefulWidget {
  final GameLevel level;

  const PlaySessionScreen(this.level, {super.key});

  @override
  State<PlaySessionScreen> createState() => _PlaySessionScreenState();
}

class _PlaySessionScreenState extends State<PlaySessionScreen> {
  static final _log = Logger('PlaySessionScreen');

  static const _celebrationDuration = Duration(milliseconds: 2000);

  static const _preCelebrationDuration = Duration(milliseconds: 500);

  bool _duringCelebration = false;

  late DateTime _startOfPlay;

  AudioController audioController = AudioController();

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LevelState(
            goal: widget.level.difficulty,
            onWin: _playerWon,
          ),
        ),
      ],
      child: IgnorePointer(
        ignoring: _duringCelebration,
        child: Scaffold(
          backgroundColor: palette.backgroundPlaySession,
          body: Stack(
            children: [
              SafeArea(
                child: Center(
                  // This is the entirety of the "game".
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Back(path: '/play'),
                            GoldCoin(),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15, left: 7),
                          width: 325,
                          height: 210,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                bottom: 0,
                                child: Container(
                                  width: 325,
                                  height: 196,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const Text(
                                        'House',
                                        style: TextStyle(
                                            color: Color(0xFF315496),
                                            fontWeight: FontWeight.w900,
                                            fontSize: 32),
                                      ),
                                      Container(
                                        width: 66,
                                        height: 46,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFBBD0FF),
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0xFFB8C0FF),
                                                offset: Offset(0, 6),
                                              )
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 13,
                                child: Container(
                                  width: 83,
                                  height: 28,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFB8C0FF),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: const Color(0xFFEEF0F6),
                                        width: 2,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            answerWidget('A', const Color(0xFFFF99C8)),
                            const SizedBox(width: 9),
                            answerWidget('B', const Color(0xFFFCF6BD)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            answerWidget('C', const Color(0xFFD0F4DE)),
                            const SizedBox(width: 9),
                            answerWidget('D', const Color(0xFFA9DEF9)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 36),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox.expand(
                child: Visibility(
                  visible: _duringCelebration,
                  child: IgnorePointer(
                    child: Confetti(
                      isStopped: !_duringCelebration,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _startOfPlay = DateTime.now();

    // Preload ad for the win screen.
    final adsRemoved = context.read<InAppPurchaseController?>()?.adRemoval.active ?? false;
    if (!adsRemoved) {
      final adsController = context.read<AdsController?>();
      adsController?.preloadAd();
    }
  }

  Future<void> _playerWon() async {
    _log.info('Level ${widget.level.number} won');

    final score = Score(
      widget.level.number,
      widget.level.difficulty,
      DateTime.now().difference(_startOfPlay),
    );

    final playerProgress = context.read<PlayerProgress>();
    playerProgress.setLevelReached(widget.level.number);

    // Let the player see the game just after winning for a bit.
    await Future<void>.delayed(_preCelebrationDuration);
    if (!mounted) return;

    setState(() {
      _duringCelebration = true;
    });

    final audioController = context.read<AudioController>();
    audioController.playSfx(SfxType.congrats);

    final gamesServicesController = context.read<GamesServicesController?>();
    if (gamesServicesController != null) {
      // Award achievement.
      if (widget.level.awardsAchievement) {
        await gamesServicesController.awardAchievement(
          android: widget.level.achievementIdAndroid!,
          iOS: widget.level.achievementIdIOS!,
        );
      }

      // Send score to leaderboard.
      await gamesServicesController.submitLeaderboardScore(score);
    }

    /// Give the player some time to see the celebration animation.
    await Future<void>.delayed(_celebrationDuration);
    if (!mounted) return;

    GoRouter.of(context).go('/play/won', extra: {'score': score});
  }
}

class Listen extends StatefulWidget {
  final AudioController audioController;

  const Listen({super.key, required this.audioController});

  @override
  State<Listen> createState() => _ListenState();
}

class _ListenState extends State<Listen> {
  late AudioController audioController;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    audioController = widget.audioController;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), boxShadow: [
        isPressed
            ? BoxShadow(spreadRadius: -5)
            : BoxShadow(
                color: Color(0x3f000000),
                offset: Offset(0, 4),
                blurRadius: 2,
              ),
      ]),
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            Color(0xffBBD0FF),
          ),
        ),
        onPressed: () {
          setState(() {
            isPressed = !isPressed;

            Future.delayed(
              Duration(milliseconds: 400),
              () {
                setState(() {
                  isPressed = !isPressed;
                });
              },
            );
          });
          audioController.playSfx(SfxType.congrats);
        },
        child: Image.asset('assets/images/speaker.png'),
      ),
    );
  }
}

Widget answerWidget(String title, Color color) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    width: 167,
    height: 181,
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            width: 167,
            height: 167,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 2),
                  )
                ]),
          ),
        ),
        Positioned(
          top: 0,
          left: 42,
          child: Container(
            alignment: Alignment.center,
            width: 83,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFFB8C0FF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFEEF0F6),
                width: 2,
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
