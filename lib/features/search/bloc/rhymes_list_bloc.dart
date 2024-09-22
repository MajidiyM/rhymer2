import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rhymer2/api/api.dart';
import 'package:rhymer2/api/models/models.dart';
import 'package:rhymer2/repositories/history/history.dart';

part 'rhymes_list_event.dart';
part 'rhymes_list_state.dart';

class RhymesListBloc extends Bloc<RhymesListEvent, RhymesListState> {
  RhymesListBloc({
    required RhymerApiClient apiClient,
    required HistoryRepositoryInterface historyRepository,
  })  : _historyRepository = historyRepository,
        _apiClient = apiClient,
        super(RhymesListInitial()) {
    on<SearchRhymes>(_onSearch);
  }

  final RhymerApiClient _apiClient;
  final HistoryRepositoryInterface _historyRepository;

  Future<void> _onSearch(
    SearchRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      emit(RhymesListLoading());
      final rhymes = await _apiClient.getRhymesList(event.query);
      final historyRhymes = rhymes.toHistory(event.query);
      _historyRepository.setRhymes(historyRhymes);
      emit(RhymesListLoaded(rhymes: rhymes));
    } catch (e) {
      emit(RhymesListFailure(error: e));
    }
  }
}
