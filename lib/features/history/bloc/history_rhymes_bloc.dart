import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rhymer2/repositories/history/models/history_rhymes.dart';

import '../../../repositories/history/history.dart';

part 'history_rhymes_event.dart';
part 'history_rhymes_state.dart';

class HistoryRhymesBloc extends Bloc<HistoryRhymesEvent, HistoryRhymesState> {
  HistoryRhymesBloc({required HistoryRepositoryInterface historyRepository})
      : _historyRepository = historyRepository,
        super(HistoryRhymesInitial()) {
    on<LoadHistoryRhymes>(_load);
    on<ClearRhymesHistory>(_clear);
  }

  final HistoryRepositoryInterface _historyRepository;
  Future<void> _load(
    LoadHistoryRhymes event,
    Emitter<HistoryRhymesState> emit,
  ) async {
    try {
      emit(HistoryRhymesLoading());
      final rhymes = await _historyRepository.getRhymesList();
      emit(HistoryRhymesLoaded(rhymes: rhymes));
    } catch (e) {
      emit(HistoryRhymesFailure(e));
    }
  }

  Future<void> _clear(
    ClearRhymesHistory event,
    Emitter<HistoryRhymesState> emit,
  ) async {
    try {
      await _historyRepository.clear();
      add(LoadHistoryRhymes());
    } catch (e) {
      log(e.toString());
    }
  }
}
