import 'package:game_card/src/model/word_model.dart';

import 'game.dart';

class DumpData {
  static final List<LevelData> levelData = [
    LevelData(
      name: 'ANIMAL',
      image: 'assets/images/cat.gif',
      entry: 5,
      prizes: 10,
      check: true,
      collectionId: 1,
    ),
    LevelData(
        name: 'HOUSE',
        image: 'assets/house/house.gif',
        entry: 7,
        prizes: 15,
        collectionId: 2),
  ];
  static Map<int, List<WordModel>> dumpTopicCollection = {
    1: [
      WordModel(image: 'assets/house/house.gif', text: 'HOUSE', sound: ''),
      WordModel(image: 'assets/images/cat.gif', text: 'ANIMAL', sound: ''),
      WordModel(image: 'assets/images/bookmark.gif', text: 'BOOK', sound: ''),
    ],
    2: [
      WordModel(image: 'assets/images/bookmark.gif', text: 'BOOK', sound: ''),
      WordModel(image: 'assets/images/cat.gif', text: 'ANIMAL', sound: ''),
    ],
  };
}
