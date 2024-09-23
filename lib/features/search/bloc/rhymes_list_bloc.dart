import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rhymer2/api/api.dart';
import 'package:rhymer2/api/models/models.dart';
import 'package:rhymer2/repositories/favorite/favorite_repository_interface.dart';
import 'package:rhymer2/repositories/history/history.dart';

part 'rhymes_list_event.dart';
part 'rhymes_list_state.dart';

class RhymesListBloc extends Bloc<RhymesListEvent, RhymesListState> {
  RhymesListBloc({
    required RhymerApiClient apiClient,
    required HistoryRepositoryInterface historyRepository,
    required FavoriteRepositoryInterface favoriteRepositoryInterface,
  })  : _historyRepository = historyRepository,
        _apiClient = apiClient,
        _favoriteRepository = favoriteRepositoryInterface,
        super(RhymesListInitial()) {
    on<SearchRhymes>(_onSearch);
    on<ToggleFavoriteRhymes>(_onToggleFavorite);
  }

  final RhymerApiClient _apiClient;
  final HistoryRepositoryInterface _historyRepository;
  final FavoriteRepositoryInterface _favoriteRepository;

  Future<void> _onSearch(
    SearchRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      emit(RhymesListLoading());
      final rhymes = await _apiClient.getRhymesList(event.query);
      final historyRhymes = rhymes.toHistory(event.query);
      await _historyRepository.setRhymes(historyRhymes);
      emit(RhymesListLoaded(rhymes: rhymes, query: event.query));
    } catch (e) {
      emit(RhymesListFailure(error: e));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      await _favoriteRepository.createOrDeleteRhymes(event.rhymes.toFavorite(
        event.query,
        event.favoriteWord,
      ));
    } catch (e) {
      emit(RhymesListFailure(error: e));
    }
  }
}
