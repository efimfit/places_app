import 'package:http/http.dart' as http;

class LocationApi {
  static const googleApiKey = '';
  static const googleSignature = '';

  Future<http.Response> getAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleApiKey');
    final response = await http.get(url);
    return response;
  }
}
