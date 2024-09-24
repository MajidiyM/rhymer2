part of 'rhymes_list_bloc.dart';

sealed class RhymesListState extends Equatable {
  RhymesListState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class RhymesListInitial extends RhymesListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class RhymesListLoading extends RhymesListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class RhymesListLoaded extends RhymesListState {
  RhymesListLoaded({
    required this.rhymes,
    required this.query,
    required List<FavoriteRhymes> favoriteRhymes,
  }) : _favoriteRhymes = favoriteRhymes;

  final String query;
  final List<String> rhymes;
  final List<FavoriteRhymes> _favoriteRhymes;

  bool isFavorite(String rhyme) {
    return _favoriteRhymes
        .where((e) => e.favoriteWord == rhyme && e.queryWord == query)
        .isNotEmpty;
  }

  @override
  List<Object?> get props =>
      super.props..addAll([rhymes, query, _favoriteRhymes]);

  RhymesListLoaded copyWith({
    String? query,
    List<String>? rhymes,
    List<FavoriteRhymes>? favoriteRhymes,
  }) {
    return RhymesListLoaded(
      rhymes: rhymes ?? this.rhymes,
      query: query ?? this.query,
      favoriteRhymes: favoriteRhymes ?? _favoriteRhymes,
    );
  }
}

final class RhymesListFailure extends RhymesListState {
  RhymesListFailure({required this.error});

  final Object error;

  @override
  // TODO: implement props
  List<Object?> get props => super.props..add(error);
}
