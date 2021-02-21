import 'package:flutter/material.dart';

import 'core/services/parse_service.dart';
import 'core/services/service_locator.dart';
import 'ui/screens/auth_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/product_add_screen.dart';
import 'ui/screens/product_detail_screen.dart';
import 'ui/theming/roylen_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  initService();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roylen',
      theme: RoylenTheme.getThemeData(),
      initialRoute: ProductAddScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
        ProductAddScreen.routeName: (context) => ProductAddScreen(),
        AuthScreen.routeName: (context) => AuthScreen(),
      },
    );
  }
}
