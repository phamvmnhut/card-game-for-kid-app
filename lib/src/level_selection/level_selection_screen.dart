// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:game_card/src/audio/audio_controller.dart';
import 'package:game_card/src/model/dump_data.dart';
import 'package:game_card/src/model/game.dart';
import 'package:provider/provider.dart';

import '../style/palette.dart';
import '../style/responsive_screen.dart';
import '../style/widget.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final audioController = context.watch<AudioController>();

    return Scaffold(
      backgroundColor: palette.backgroundMain,
      body: ResponsiveScreen(
        mainAreaProminence: 0.45,
        topMessageArea: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Back(
              path: '/',
              audioController: audioController,
            ),
            GoldCoin(
              audioController: audioController,
            ),
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
                        style:
                            TextStyle(fontFamily: 'montserrat', fontSize: 30),
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
                    // cardButton,
                    Column(
                      children: DumpData.levelData.map((e) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 17),
                          child: CardButton(
                            audioController: audioController,
                            container: Container(
                              margin: EdgeInsets.only(left: 11),
                              height: 53,
                              width: 53,
                              child: Image.asset(e.image),
                            ),
                            nameCard: e.name,
                            entryCoin: e.entry,
                            prizesCoin: e.prizes,
                            icon: Icon(
                              Icons.check_circle_outline,
                              color: Color(0xffD0F4DE),
                              size: 50,
                            ),
                            showIcon: e.check,
                            path: e.collectionId.toString(),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        rectangularMenuArea: Align(
            alignment: Alignment.centerLeft,
            child: SettingButton(audioController: audioController)),
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
