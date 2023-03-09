import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:places_app/app/app.dart';
import 'package:places_app/overview/overview.dart';

class PlaceDetail extends StatelessWidget {
  static const routeName = '/place-details';

  const PlaceDetail({super.key});
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final selectedPlace = context.read<PlacesBloc>().state.findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.id),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) =>
                      MapPage(initialLocation: selectedPlace.location),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor),
            child: const Text('View place on map'),
          )
        ],
      ),
    );
  }
}
