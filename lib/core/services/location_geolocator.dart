import 'package:Roylen/core/services/location.dart';
import 'package:geolocator/geolocator.dart';

class MyGeoLocatorLocation extends Location {
  Future<Position> determineLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(
          'Je moet toestemming geven om je positie te bepalen. Anders moet je je postcode invullen.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Je hebt permanent geen toestemming gegeven om je positie automatisch te bepalen. Als je je postcode niet invult, dan kun je geen advertenties plaatsen op Roylen.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Je hebt geen toestemming gegeven om je positie te bepalen. Je moet je postcode invullen. Anders kun je geen advertenties plaatsen.');
      }
    }
    return await Geolocator.getCurrentPosition();
  }
}
