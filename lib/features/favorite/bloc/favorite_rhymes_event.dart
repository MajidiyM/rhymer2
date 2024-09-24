part of 'favorite_rhymes_bloc.dart';

@immutable
sealed class FavoriteRhymesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class LoadFavoriteRhymes extends FavoriteRhymesEvent {}

final class ToggleFavoriteRhyme extends FavoriteRhymesEvent {
  ToggleFavoriteRhyme({required this.favoriteRhymes});

  final FavoriteRhymes favoriteRhymes;

  @override
  List<Object> get props => super.props..add(favoriteRhymes);
}
