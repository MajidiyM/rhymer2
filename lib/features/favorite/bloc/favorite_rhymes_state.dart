part of 'favorite_rhymes_bloc.dart';

@immutable
sealed class FavoriteRhymesState extends Equatable {
  List<Object> props = [];
}

final class FavoriteRhymesInitial extends FavoriteRhymesState {}

final class FavoriteRhymesLoading extends FavoriteRhymesState {}

final class FavoriteRhymesLoaded extends FavoriteRhymesState {
  FavoriteRhymesLoaded({required this.rhymes});

  final List<FavoriteRhymes> rhymes;

  @override
  List<Object> get props => super.props..add(rhymes);
}

final class FavoriteRhymesFailure extends FavoriteRhymesState {
  FavoriteRhymesFailure(this.error);

  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
