part of 'history_rhymes_bloc.dart';

@immutable
sealed class HistoryRhymesState extends Equatable {
  const HistoryRhymesState();

  @override
  List<Object> get props => [];
}

final class HistoryRhymesInitial extends HistoryRhymesState {}

final class HistoryRhymesLoading extends HistoryRhymesState {}

final class HistoryRhymesLoaded extends HistoryRhymesState {
  HistoryRhymesLoaded({required this.rhymes});

  final List<HistoryRhymes> rhymes;

  @override
  List<Object> get props => super.props..add(rhymes);
}

final class HistoryRhymesFailure extends HistoryRhymesState {
  HistoryRhymesFailure(this.error);

  final Object error;

  List<Object> get props => super.props..add(error);
}
