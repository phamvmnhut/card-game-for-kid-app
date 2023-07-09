import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:game_card/src/style/palette.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../settings/settings_screen.dart';

bool isPressed = false;

class GoldCoin extends StatefulWidget {
  final AudioController audioController;
  const GoldCoin({super.key, required this.audioController});

  @override
  State<GoldCoin> createState() => _GoldCoinState();
}

class _GoldCoinState extends State<GoldCoin> {
  late AudioController audioController;

  @override
  void initState() {
    super.initState();
    audioController = widget.audioController;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
        audioController.playSfx(SfxType.coin);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: [
            isPressed
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
              GestureDetector(
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
              GestureDetector(
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
              GestureDetector(
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
              GestureDetector(
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
  final AudioController audioController;

  const Purchase({super.key, required this.audioController});

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  late AudioController audioController;

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
            audioController.playSfx(SfxType.hehe);
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
          audioController.playSfx(SfxType.swishSwish);
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

class Back extends StatefulWidget {
  final String path;
  final AudioController audioController;
  const Back({super.key, required this.path, required this.audioController});

  @override
  State<Back> createState() => _BackState();
}

class _BackState extends State<Back> {
  late AudioController audioController;
  late String path;

  @override
  void initState() {
    super.initState();
    path = widget.path;
    audioController = widget.audioController;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        audioController.playSfx(SfxType.lalala);
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

        Future.delayed(
          Duration(milliseconds: 700),
          () {
            GoRouter.of(context).pop();
          },
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: [
            isPressed
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

class SettingButton extends StatefulWidget {
  final AudioController audioController;

  const SettingButton({super.key, required this.audioController});

  @override
  State<SettingButton> createState() => _SettingButtonState();
}

class _SettingButtonState extends State<SettingButton> {
  late AudioController audioController;

  @override
  void initState() {
    super.initState();
    audioController = widget.audioController;
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return GestureDetector(
      onTap: () {
        audioController.playSfx(SfxType.note);
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
        Future.delayed(
          Duration(milliseconds: 700),
          () {
            showDialog<Widget>(
              context: context,
              builder: (context) {
                return Theme(
                  data: ThemeData(
                    dialogBackgroundColor: palette.backgroundMain,
                  ),
                  child: AlertDialog(
                    content: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: SettingsScreen()),
                  ),
                );
              },
            );
          },
        );
      },
      child: AnimatedContainer(
        height: 50,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          boxShadow: [
            isPressed
                ? BoxShadow()
                : BoxShadow(
                    color: Color(0x3f000000),
                    offset: Offset(0, 4),
                    blurRadius: 2,
                  ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Image.asset(
            'assets/images/settings.png',
            color: Color(0xffA7ABB5),
          ),
        ),
      ),
    );
  }
}

class CardButton extends StatefulWidget {
  final Container container;
  final AudioController audioController;
  final String nameCard;
  final int entryCoin, prizesCoin;
  final Icon icon;
  final bool showIcon;
  final String path;
  const CardButton({
    super.key,
    required this.audioController,
    required this.container,
    required this.nameCard,
    required this.entryCoin,
    required this.prizesCoin,
    required this.icon,
    required this.showIcon,
    required this.path,
  });

  @override
  State<CardButton> createState() => _CardButtonState();

  CardButton copyWith({
    Container? container,
    AudioController? audioController,
    String? nameCard,
    int? entryCoin,
    int? prizesCoin,
    Icon? icon,
    bool? showIcon,
    String? path,
  }) {
    return CardButton(
      audioController: audioController ?? this.audioController,
      container: container ?? this.container,
      nameCard: nameCard ?? this.nameCard,
      entryCoin: entryCoin ?? this.entryCoin,
      prizesCoin: prizesCoin ?? this.prizesCoin,
      icon: icon ?? this.icon,
      showIcon: showIcon ?? this.showIcon,
      path: path ?? this.path,
    );
  }
}

class _CardButtonState extends State<CardButton> {
  late Container container;
  late AudioController audioController;
  late String nameCard;
  late int entryCoin, prizesCoin;
  late Icon icon;
  late bool showIcon;
  late String path;

  @override
  void initState() {
    super.initState();
    container = widget.container;
    audioController = widget.audioController;
    nameCard = widget.nameCard;
    entryCoin = widget.entryCoin;
    prizesCoin = widget.prizesCoin;
    icon = widget.icon;
    showIcon = widget.showIcon;
    path = widget.path;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        audioController.playSfx(SfxType.haw);
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
              GoRouter.of(context).go('/play/session/$path');
            },
          );
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 85,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            isPressed
                ? BoxShadow()
                : BoxShadow(
                    color: Color(0x3f000000),
                    offset: Offset(0, 4),
                    blurRadius: 2,
                  ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  container,
                  Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 17),
                          child: Text(
                            nameCard,
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
                        padding: const EdgeInsets.only(left: 7, bottom: 17),
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(8, 17, 0, 0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Text(
                                        'Entry',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          height: 1.185,
                                          color: Color(0xffFCBD11),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Text(
                                        '$entryCoin',
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
                                  ],
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
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
                              padding: const EdgeInsets.only(right: 4),
                              child: Text(
                                '$prizesCoin',
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
                              child: Image.asset('assets/images/coin.gif',
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
              child: showIcon ? icon : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
