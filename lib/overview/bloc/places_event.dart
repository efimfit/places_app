// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'places_bloc.dart';

abstract class PlacesEvent {
  const PlacesEvent();
}

class PlacesFetched extends PlacesEvent {
  const PlacesFetched(this.table);

  final String table;
}

class PlaceAdded extends PlacesEvent {
  const PlaceAdded(this.title, this.image, this.location);

  final String title;
  final File image;
  final Location location;
}

class PlaceDeleted extends PlacesEvent {
  const PlaceDeleted(this.table, this.id);

  final String table;
  final String id;
}
