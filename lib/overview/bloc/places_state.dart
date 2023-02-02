// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'places_bloc.dart';

enum PlacesStatus { initial, loading, success, failed }

class PlacesState {
  final List<Place> items;
  final PlacesStatus status;

  PlacesState({
    this.items = const [],
    this.status = PlacesStatus.initial,
  });

  Place findById(String id) {
    return items.firstWhere((e) => e.id == id);
  }

  PlacesState copyWith({
    List<Place>? items,
    PlacesStatus? status,
  }) {
    return PlacesState(
      items: items ?? this.items,
      status: status ?? this.status,
    );
  }
}
