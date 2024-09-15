class Rhymes {
  Rhymes({required this.words});

  final List<String> words;

  factory Rhymes.fromList(List<String> list) {
    return Rhymes(words: list);
  }
}
