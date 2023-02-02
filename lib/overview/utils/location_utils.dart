import 'package:places_app/overview/overview.dart';

class LocationUtils {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    const googleApiKey = LocationApi.googleApiKey;
    const googleSignature = LocationApi.googleSignature;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$googleApiKey&$googleSignature';
  }
}
