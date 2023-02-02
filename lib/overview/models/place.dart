import 'dart:io';

import 'package:places_app/overview/overview.dart';

class Place {
  final String id;
  final String title;
  final Location location;
  final File image;

  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}
