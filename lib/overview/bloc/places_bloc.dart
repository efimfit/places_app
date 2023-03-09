import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:places_app/overview/overview.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesBloc({required PlacesRepository locationsRepository})
      : _locationsRepository = locationsRepository,
        super(PlacesState()) {
    on<PlacesFetched>(_onPlacesFetched);
    on<PlaceAdded>(_onPlaceAdded);
    on<PlaceDeleted>(_onPlaceDeleted);
  }

  final PlacesRepository _locationsRepository;

  Future<void> _onPlaceAdded(
      PlaceAdded event, Emitter<PlacesState> emit) async {
    emit(state.copyWith(status: PlacesStatus.loading));
    final newPlace = await _locationsRepository.getPlace(
        event.location, event.title, event.image);
    await _locationsRepository.insert('user_places', newPlace);
    final newItems = state.items..add(newPlace);
    emit(state.copyWith(items: newItems, status: PlacesStatus.success));
  }

  Future<void> _onPlacesFetched(
      PlacesFetched event, Emitter<PlacesState> emit) async {
    emit(state.copyWith(status: PlacesStatus.loading));
    final newItems = await _locationsRepository.getData(event.table);
    emit(state.copyWith(items: newItems, status: PlacesStatus.success));
  }

  Future<void> _onPlaceDeleted(
      PlaceDeleted event, Emitter<PlacesState> emit) async {
    emit(state.copyWith(status: PlacesStatus.loading));
    final deleteIndex = state.items.indexWhere((e) => e.id == event.id);
    final newItems = state.items..removeAt(deleteIndex);
    await _locationsRepository.delete(event.table, event.id);
    emit(state.copyWith(items: newItems, status: PlacesStatus.success));
  }
}
