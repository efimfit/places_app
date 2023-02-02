import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:places_app/overview/overview.dart';
import 'package:places_app/add_place/add_place.dart';
import 'package:places_app/place_details/place_details.dart';

class PlacesOverview extends StatelessWidget {
  const PlacesOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlace.routeName);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: BlocBuilder<PlacesBloc, PlacesState>(builder: (context, state) {
        return state.status == PlacesStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : state.items.isEmpty
                ? const Center(child: Text('No places yet'))
                : ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (cxt, i) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(state.items[i].image),
                        ),
                        title: Text(state.items[i].title),
                        subtitle: Text(state.items[i].location.address),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            context.read<PlacesBloc>().add(
                                PlaceDeleted('user_places', state.items[i].id));
                          },
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(PlaceDetail.routeName,
                              arguments: state.items[i].id);
                        },
                      );
                    },
                  );
      }),
    );
  }
}
