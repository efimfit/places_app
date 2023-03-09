import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as core_location;

import 'package:places_app/app/app.dart';
import 'package:places_app/overview/overview.dart';

class LocationInput extends StatefulWidget {
  const LocationInput(this.selectPlace, {super.key});

  final Function selectPlace;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  var _previewImageUrl = '';

  void _showPreview(double lat, double lon) {
    final staticMapImageUrl = LocationUtils.generateLocationPreviewImage(
      latitude: lat,
      longitude: lon,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      print('location');
      final locationData = await core_location.Location().getLocation();
      _showPreview(locationData.latitude!, locationData.longitude!);
      widget.selectPlace(locationData.latitude, locationData.longitude);
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    print('select');
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const MapPage(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.selectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl.isEmpty
              ? const Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary),
                label: const Text('Current location')),
            TextButton.icon(
                onPressed: _selectOnMap,
                icon: const Icon(Icons.map),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary),
                label: const Text('Select on map')),
          ],
        )
      ],
    );
  }
}
