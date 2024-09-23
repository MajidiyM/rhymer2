import 'package:realm/realm.dart';
import 'package:rhymer2/repositories/favorite/favorite.dart';
import 'package:rhymer2/repositories/favorite/model/favorite_rhymes.dart';

class FavoriteRepository implements FavoriteRepositoryInterface {
  FavoriteRepository({required this.realm});

  final Realm realm;

  @override
  Future<List<FavoriteRhymes>> getRhymesList() async {
    return realm.all<FavoriteRhymes>().toList();
  }

  @override
  Future<void> createOrDeleteRhymes(FavoriteRhymes rhymes) async {
    final rhymesList = realm.query<FavoriteRhymes>(
        "queryWord = '${rhymes.queryWord}' and favoriteWord == '${rhymes.favoriteWord}'");
    if (rhymesList.isNotEmpty) {
      for (var e in rhymesList) {
        realm.write(() => realm.delete(e));
      }
      return;
    }
    realm.write(() => realm.add(rhymes));
  }

  @override
  Future<void> clear() async {
    realm.write(() => realm.deleteAll<FavoriteRhymes>());
  }
}
