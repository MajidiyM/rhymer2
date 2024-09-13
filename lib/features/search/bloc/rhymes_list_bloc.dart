import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rhymer2/api/api.dart';

part 'rhymes_list_event.dart';
part 'rhymes_list_state.dart';

class RhymesListBloc extends Bloc<RhymesListEvent, RhymesListState> {
  RhymesListBloc({required this.apiClient}) : super(RhymesListInitial()) {
    on<SearchRhymes>(_onSearch);
  }

  final RhymerApiClient apiClient;

  Future<void> _onSearch(
    SearchRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      emit(RhymesListLoading());
      final rhymes = await apiClient.getRhymesList(event.query);
      emit(RhymesListLoaded(rhymes: rhymes));
    } catch (e) {
      emit(RhymesListFailure(error: e));
    }
  }
}
