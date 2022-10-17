import 'package:geocoding/geocoding.dart';

class CalendarEventEntity {
  CalendarEventEntity({
    required this.summary,
    required this.description,
    required this.location,
    required this.dtstart,
    required this.dtend,
  });

  bool isCoord() {
    return (latitude != 0) && (longitude != 0);
  }

  final String summary;
  final String description;
  final DateTime dtstart;
  final DateTime dtend;
  final String location;
  double latitude = 0;
  double longitude = 0;

  Future<double> getLatitude() async {
    return latitude;
  }

  Future<double> getLongitude() async {
    return longitude;
  }

  Future<bool> loadCoords() async {
    if (location.isNotEmpty && latitude == 0 && longitude == 00) {
      try {
        final List<Location> locations = await locationFromAddress(location);
        latitude = locations.first.latitude;
        longitude = locations.first.longitude;
        return true;
      } on Exception catch (_) {}
    }

    return false;
  }

  @override
  String toString() => summary;
}
