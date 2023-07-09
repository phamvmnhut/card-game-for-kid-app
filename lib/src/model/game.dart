class LevelData {
  String name;
  int entry;
  int prizes;
  String image;
  bool check;
  int collectionId;

  LevelData({
    required this.name,
    required this.image,
    required this.entry,
    required this.prizes,
    this.check = false,
    required this.collectionId,
  });
}
