import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rhymer2/repositories/favorite/favorite.dart';
import 'package:rhymer2/repositories/favorite/model/favorite_rhymes.dart';

part 'favorite_rhymes_event.dart';
part 'favorite_rhymes_state.dart';

class FavoriteRhymesBloc
    extends Bloc<FavoriteRhymesEvent, FavoriteRhymesState> {
  FavoriteRhymesBloc({required FavoriteRepositoryInterface favoriteRepository})
      : _favoriteRepository = favoriteRepository,
        super(FavoriteRhymesInitial()) {
    on<LoadFavoriteRhymes>(_load);
    on<ToggleFavoriteRhyme>(_toggleFavorite);
  }

  final FavoriteRepositoryInterface _favoriteRepository;

  Future<void> _load(
    LoadFavoriteRhymes event,
    Emitter<FavoriteRhymesState> emit,
  ) async {
    try {
      emit(FavoriteRhymesLoading());
      final rhymes = await _favoriteRepository.getRhymesList();
      emit(FavoriteRhymesLoaded(rhymes: rhymes));
    } catch (e) {
      emit(FavoriteRhymesFailure(e));
    }
  }

  Future<void> _toggleFavorite(
    ToggleFavoriteRhyme event,
    Emitter<FavoriteRhymesState> emit,
  ) async {
    try {
      _favoriteRepository.createOrDeleteRhymes(event.favoriteRhymes);
      add(LoadFavoriteRhymes());
    } catch (e) {
      log(e.toString());
    }
  }
}
