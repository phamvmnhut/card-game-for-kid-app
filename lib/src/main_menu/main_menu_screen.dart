// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../games_services/games_services.dart';
import '../settings/settings.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

bool check = false;

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final gamesServicesController = context.watch<GamesServicesController?>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return Scaffold(
      backgroundColor: palette.backgroundMain,
      body: ResponsiveScreen(
        topMessageArea: Align(
          alignment: Alignment.centerRight,
          child: GoldCoin(),
        ),
        mainAreaProminence: 0.45,
        squarishMainArea: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SquareContainer(
              audioController: audioController,
            ),
            Transform.rotate(
              angle: -0.1,
              child: const Text(
                'Card game',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Permanent Marker',
                  fontSize: 55,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Start(audioController: audioController),
            _gap,
            if (gamesServicesController != null) ...[
              _hideUntilReady(
                ready: gamesServicesController.signedIn,
                child: FilledButton(
                  onPressed: () => gamesServicesController.showAchievements(),
                  child: const Text('Achievements'),
                ),
              ),
              _gap,
              _hideUntilReady(
                ready: gamesServicesController.signedIn,
                child: FilledButton(
                  onPressed: () => gamesServicesController.showLeaderboard(),
                  child: const Text('Leaderboard'),
                ),
              ),
              _gap,
            ],
            Purchase(),
            _gap,
            Setting(
              audioController: audioController,
            ),
            _gap,
            ValueListenableBuilder<bool>(
              valueListenable: settingsController.muted,
              builder: (context, muted, child) {
                return IconButton(
                  onPressed: () => settingsController.toggleMuted(),
                  icon: Icon(muted ? Icons.volume_off : Icons.volume_up),
                );
              },
            ),
            const Text('Music by Mr Smith'),
            _gap,
          ],
        ),
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3f000000),
            offset: Offset(0, 4),
            blurRadius: 2,
          ),
        ],
      ),
      child: FilledButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Color(0xffBBD0FF))),
        onPressed: () => GoRouter.of(context).push('/settings'),
        child: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  /// Prevents the game from showing game-services-related menu items
  /// until we're sure the player is signed in.
  ///
  /// This normally happens immediately after game start, so players will not
  /// see any flash. The exception is folks who decline to use Game Center
  /// or Google Play Game Services, or who haven't yet set it up.
  Widget _hideUntilReady({required Widget child, required Future<bool> ready}) {
    return FutureBuilder<bool>(
      future: ready,
      builder: (context, snapshot) {
        // Use Visibility here so that we have the space for the buttons
        // ready.
        return Visibility(
          visible: snapshot.data ?? false,
          maintainState: true,
          maintainSize: true,
          maintainAnimation: true,
          child: child,
        );
      },
    );
  }

  static const Widget _gap = SizedBox(height: 10);
}

class GoldCoin extends StatefulWidget {
  const GoldCoin({super.key});

  @override
  State<GoldCoin> createState() => _GoldCoinState();
}

class _GoldCoinState extends State<GoldCoin> {
  AudioPlayer audioController = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        setState(() {
          check = !check;
          Future.delayed(
            Duration(milliseconds: 400),
            () {
              setState(() {
                check = !check;
              });
            },
          );
        });
        audioController.play(AssetSource('sfx/coin.wav'));
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: [
            check
                ? BoxShadow()
                : BoxShadow(
                    color: Color(0x3f000000),
                    offset: Offset(0, 4),
                    blurRadius: 2,
                  )
          ],
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(12, 7, 12, 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '40',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xfffcbd11),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 17,
                    child: Image.asset('assets/images/coin.gif',
                        semanticLabel: 'Coin'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SquareContainer extends StatefulWidget {
  final AudioController audioController;

  const SquareContainer({super.key, required this.audioController});

  @override
  State<SquareContainer> createState() => _SquareContainerState();
}

class _SquareContainerState extends State<SquareContainer> {
  bool isPressed1 = false;
  bool isPressed2 = false;
  bool isPressed3 = false;
  bool isPressed4 = false;
  late AudioController audioController;

  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    audioController = widget.audioController;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      height: 250,
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isPressed1 = !isPressed1;

                    Future.delayed(
                      Duration(milliseconds: 400),
                      () {
                        setState(() {
                          isPressed1 = !isPressed1;
                        });
                      },
                    );
                  });
                  audioController.playSfx(SfxType.huhsh);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffFF99C8),
                      boxShadow: [
                        isPressed1
                            ? BoxShadow()
                            : BoxShadow(
                                color: Color(0x3f000000),
                                offset: Offset(0, 5),
                                blurRadius: 2,
                              )
                      ]),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isPressed2 = !isPressed2;

                    Future.delayed(
                      Duration(milliseconds: 400),
                      () {
                        setState(() {
                          isPressed2 = !isPressed2;
                        });
                      },
                    );
                  });
                  audioController.playSfx(SfxType.wssh);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffFCF6BD),
                      boxShadow: [
                        isPressed2
                            ? BoxShadow()
                            : BoxShadow(
                                color: Color(0x3f000000),
                                offset: Offset(0, 5),
                                blurRadius: 2,
                              ),
                      ]),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isPressed3 = !isPressed3;

                    Future.delayed(
                      Duration(milliseconds: 400),
                      () {
                        setState(() {
                          isPressed3 = !isPressed3;
                        });
                      },
                    );
                  });
                  audioController.playSfx(SfxType.buttonTap);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffD0F4DE),
                      boxShadow: [
                        isPressed3
                            ? BoxShadow()
                            : BoxShadow(
                                color: Color(0x3f000000),
                                offset: Offset(0, 5),
                                blurRadius: 2,
                              ),
                      ]),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isPressed4 = !isPressed4;

                    Future.delayed(
                      Duration(milliseconds: 400),
                      () {
                        setState(() {
                          isPressed4 = !isPressed4;
                        });
                      },
                    );
                  });
                  audioController.playSfx(SfxType.erase);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffA9DEF9),
                      boxShadow: [
                        isPressed4
                            ? BoxShadow()
                            : BoxShadow(
                                color: Color(0x3f000000),
                                offset: Offset(0, 5),
                                blurRadius: 2,
                              ),
                      ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Start extends StatefulWidget {
  final AudioController audioController;

  const Start({super.key, required this.audioController});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
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
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(25), boxShadow: [
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
            Future.delayed(
              Duration(milliseconds: 700),
              () {
                GoRouter.of(context).go('/play');
              },
            );
          });
          audioController.playSfx(SfxType.congrats);
        },
        child: const Text(
          'Start',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class Purchase extends StatefulWidget {
  const Purchase({super.key});

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(25), boxShadow: [
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
            audioPlayer.play(AssetSource('sfx/ehehee1.mp3'));
          });
        },
        child: const Text(
          'Purchase',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class Setting extends StatefulWidget {
  final AudioController audioController;

  const Setting({super.key, required this.audioController});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          isPressed
              ? BoxShadow(spreadRadius: -5)
              : BoxShadow(
                  color: Color(0x3f000000),
                  offset: Offset(0, 4),
                  blurRadius: 2,
                ),
        ],
      ),
      child: FilledButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Color(0xffBBD0FF))),
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
            Future.delayed(
              Duration(milliseconds: 700),
              () {
                GoRouter.of(context).push('/settings');
              },
            );
          });
          audioController.playSfx(SfxType.swishSwish);
        },
        child: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
