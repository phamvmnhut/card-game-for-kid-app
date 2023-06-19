// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:game_card/src/settings/settings_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../main_menu/main_menu_screen.dart';
import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import 'levels.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();

    return Scaffold(
      backgroundColor: palette.backgroundMain,
      body: ResponsiveScreen(
          mainAreaProminence: 0.45,
          topMessageArea: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Back(path: '/'),
              GoldCoin(),
            ],
          ),
          squarishMainArea: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Select level',
                          style: TextStyle(
                              fontFamily: 'Permanent Marker', fontSize: 30),
                        ),
                      ),
                      const SizedBox(height: 50),
                      // Expanded(
                      //   child: ListView(
                      //     children: [
                      //       for (final level in gameLevels)
                      //         ListTile(
                      //           enabled: playerProgress.highestLevelReached >=
                      //               level.number - 1,
                      //           onTap: () {
                      //             final audioController = context.read<AudioController>();
                      //             audioController.playSfx(SfxType.buttonTap);
                      //
                      //             GoRouter.of(context)
                      //                 .go('/play/session/${level.number}');
                      //           },
                      //           leading: Text(level.number.toString()),
                      //           title: Text('Level #${level.number}'),
                      //         ),
                      //     ],
                      //   ),
                      // ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          GoRouter.of(context).go('/play/session/1');
                        },
                        child: Container(
                          height: 85,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 11),
                                      height: 53,
                                      width: 53,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Color(0xffD9D9D9),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 17),
                                            child: Text(
                                              'ANIMAL',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                height: 1.185,
                                                color: Color(0xff4a6495),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, bottom: 17),
                                          child: Row(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      8, 17, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 4),
                                                        child: Text(
                                                          'Entry',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            height: 1.185,
                                                            color: Color(
                                                                0xffFCBD11),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 4),
                                                        child: Text(
                                                          '5',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            height: 1.185,
                                                            color: Color(
                                                                0xffFCBD11),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 17,
                                                        child: Image.asset(
                                                            'assets/images/coin.gif',
                                                            semanticLabel:
                                                                'Coin'),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 17),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4),
                                                child: Text(
                                                  'Prizes',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.185,
                                                    color: Color(0xff4A6495),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4),
                                                child: Text(
                                                  '5',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.185,
                                                    color: Color(0xffFCBD11),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 17,
                                                child: Image.asset(
                                                    'assets/images/coin.gif',
                                                    semanticLabel: 'Coin'),
                                              ),
                                              SizedBox(
                                                width: 21,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.check_circle_outline,
                                  color: Color(0xffD0F4DE),
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          GoRouter.of(context).go('/play/session/2');
                        },
                        child: Container(
                          height: 85,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 11),
                                      height: 53,
                                      width: 53,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Color(0xffD9D9D9),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 17),
                                            child: Text(
                                              'HOUSE',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                height: 1.185,
                                                color: Color(0xff4a6495),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, bottom: 17),
                                          child: Row(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      8, 17, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 4),
                                                        child: Text(
                                                          'Entry',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            height: 1.185,
                                                            color: Color(
                                                                0xffFCBD11),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 4),
                                                        child: Text(
                                                          '5',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            height: 1.185,
                                                            color: Color(
                                                                0xffFCBD11),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 17,
                                                        child: Image.asset(
                                                            'assets/images/coin.gif',
                                                            semanticLabel:
                                                                'Coin'),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 21, bottom: 17),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4),
                                                child: Text(
                                                  'Prizes',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.185,
                                                    color: Color(0xff4A6495),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4),
                                                child: Text(
                                                  '5',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.185,
                                                    color: Color(0xffFCBD11),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 17,
                                                child: Image.asset(
                                                    'assets/images/coin.gif',
                                                    semanticLabel: 'Coin'),
                                              ),
                                              SizedBox(
                                                width: 21,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      showDialog<Widget>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: SettingsScreen()),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Image.asset(
                          'assets/images/settings.png',
                          color: Color(0xffA7ABB5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          rectangularMenuArea: Container()
          // FilledButton(
          //   onPressed: () {
          //     GoRouter.of(context).go('/');
          //   },
          //   child: const Text('Back'),
          // ),
          ),
    );
  }
}

class Back extends StatefulWidget {
  final String path;
  const Back({super.key, required this.path});

  @override
  State<Back> createState() => _BackState();
}

class _BackState extends State<Back> {
  AudioPlayer audioController = AudioPlayer();
  late String path;

  @override
  void initState() {
    super.initState();
    path = widget.path;
  }

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
        audioController.play(AssetSource('sfx/hash1.mp3'));
        Future.delayed(
          Duration(milliseconds: 700),
          () {
            GoRouter.of(context).go('$path');
          },
        );
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
          color: Color(0xffBBD0FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 46,
                height: 36,
                margin: EdgeInsets.fromLTRB(12, 7, 12, 7),
                child: Image.asset(
                  'assets/images/back.png',
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
