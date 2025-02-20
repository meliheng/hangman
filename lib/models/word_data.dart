class WordData {
  final String word;
  final String description;

  const WordData({required this.word, required this.description});
}

final List<WordData> wordList = [
  const WordData(
    word: "FLUTTER",
    description: "A UI framework by Google for building beautiful applications",
  ),
  const WordData(
    word: "DART",
    description: "The programming language used with Flutter",
  ),
  const WordData(
    word: "MOBILE",
    description: "Type of devices that can run Flutter apps",
  ),
  const WordData(
    word: "WIDGET",
    description: "Basic building block of Flutter UI",
  ),
  const WordData(
    word: "STATE",
    description: "Data that can change during the lifetime of a widget",
  ),
];
