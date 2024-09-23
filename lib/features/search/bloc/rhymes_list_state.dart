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
  });
  final String query;
  final List<String> rhymes;

  @override
  List<Object?> get props => super.props..addAll([rhymes, query]);
}

final class RhymesListFailure extends RhymesListState {
  RhymesListFailure({required this.error});

  final Object error;

  @override
  // TODO: implement props
  List<Object?> get props => super.props..add(error);
}
