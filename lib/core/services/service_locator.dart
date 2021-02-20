import 'package:get_it/get_it.dart';

import './auth.dart';
import './auth_b4a.dart';

GetIt locator = GetIt.instance;

void setupServiceLocator() async {
  locator.registerLazySingleton<Auth>(() => AuthB4A());
}
