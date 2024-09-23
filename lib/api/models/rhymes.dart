import 'package:uuid/uuid.dart';

import '../../repositories/favorite/model/model.dart';
import '../../repositories/history/models/models.dart';

class Rhymes {
  Rhymes({required this.words});

  final List<String> words;

  factory Rhymes.fromList(List<String> list) {
    return Rhymes(words: list);
  }
}

extension RhymesListExtensions on List<String> {
  HistoryRhymes toHistory(String queryWord) {
    return HistoryRhymes(
      Uuid().v4().toString(),
      queryWord,
      words: this,
    );
  }

  FavoriteRhymes toFavorite(String queryWord, String favoriteWord) {
    return FavoriteRhymes(
      Uuid().v4().toString(),
      queryWord,
      favoriteWord,
      DateTime.now(),
      words: this,
    );
  }
}
