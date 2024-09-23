import 'package:rhymer2/repositories/favorite/model/favorite_rhymes.dart';

abstract interface class FavoriteRepositoryInterface {
  Future<List<FavoriteRhymes>> getRhymesList();
  Future<void> createOrDeleteRhymes(FavoriteRhymes rhymes);
  Future<void> clear();
}
