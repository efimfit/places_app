import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:places_app/overview/overview.dart';
import 'package:places_app/places_app.dart';

void main() {
  runApp(RepositoryProvider(
    create: (context) => PlacesRepository(LocationApi()),
    child: const PlacesApp(),
  ));
}
