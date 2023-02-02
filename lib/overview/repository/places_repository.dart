import 'dart:io';
import 'dart:convert';
import 'package:sqflite/sqflite.dart' as sql;

import 'package:places_app/overview/overview.dart';

class PlacesRepository {
  final LocationApi locationApi;

  PlacesRepository(this.locationApi);

  Future<Place> getPlace(Location location, String title, File image) async {
    final response =
        await locationApi.getAddress(location.latitude, location.longitude);
    final newAddress =
        json.decode(response.body)['results'][0]['formatted_address'];
    final newLocation = location.copyWith(address: newAddress);

    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: newLocation,
        image: image);
    return newPlace;
  }

  Future<List<Place>> getData(String table) async {
    final db = await SqliteDatabase.getDatabase();
    final dataList = await db.query(table);
    final newItems = dataList
        .map(
          (e) => Place(
            id: e['id'] as String,
            title: e['title'] as String,
            location: Location(
                latitude: e['lat'] as double,
                longitude: e['lon'] as double,
                address: e['address'] as String),
            image: File(e['image'] as String),
          ),
        )
        .toList();
    return newItems;
  }

  Future<void> insert(String table, Place place) async {
    final data = {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'lat': place.location.latitude,
      'lon': place.location.longitude,
      'address': place.location.address,
    };
    final db = await SqliteDatabase.getDatabase();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future<void> delete(String table, String id) async {
    final db = await SqliteDatabase.getDatabase();
    db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
