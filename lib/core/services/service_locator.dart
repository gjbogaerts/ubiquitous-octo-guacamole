import 'package:get_it/get_it.dart';

import './auth.dart';
import './auth_b4a.dart';
import './location.dart';
import './location_geolocator.dart';
import './validator_abstract.dart';
import './validator_my.dart';

GetIt locator = GetIt.instance;

void setupServiceLocator() async {
  locator.registerLazySingleton<Auth>(() => AuthB4A());
  locator.registerLazySingleton<Location>(() => MyGeoLocatorLocation());
  locator.registerLazySingleton<ValidatorAbstract>(() => MyValidator());
}
