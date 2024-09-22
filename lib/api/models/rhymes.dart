import 'package:uuid/uuid.dart';

import '../../repositories/history/models/models.dart';

class Rhymes {
  Rhymes({required this.words});

  final List<String> words;

  factory Rhymes.fromList(List<String> list) {
    return Rhymes(words: list);
  }
}

extension RhymesListExtensions on List<String> {
  HistoryRhymes toHistory(String word) {
    return HistoryRhymes(
      Uuid().v4().toString(),
      word,
      words: this,
    );
  }
}
