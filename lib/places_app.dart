import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:places_app/add_place/add_place.dart';
import 'package:places_app/overview/overview.dart';
import 'package:places_app/place_details/place_details.dart';

class PlacesApp extends StatelessWidget {
  const PlacesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PlacesBloc(locationsRepository: context.read<PlacesRepository>())
            ..add(const PlacesFetched('user_places')),
      child: MaterialApp(
        title: 'Great places',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        )),
        home: const PlacesOverview(),
        routes: {
          AddPlace.routeName: (context) => const AddPlace(),
          PlaceDetail.routeName: (context) => const PlaceDetail(),
        },
      ),
    );
  }
}
