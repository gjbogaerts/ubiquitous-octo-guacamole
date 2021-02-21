import 'package:geolocator/geolocator.dart';

abstract class Location {
  Future<Position> determineLocation();
}
