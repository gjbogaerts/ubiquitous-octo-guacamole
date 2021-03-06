import 'package:flutter/material.dart';

import 'core/services/parse_service.dart';
import 'core/services/service_locator.dart';
import 'ui/screens/auth_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/product_add_screen.dart';
import 'ui/screens/product_detail_screen.dart';
import 'ui/screens/product_contact_form_screen.dart';
import 'ui/theming/roylen_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initService();
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roylen',
      theme: RoylenTheme.getThemeData(),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
        ProductAddScreen.routeName: (context) => ProductAddScreen(),
        AuthScreen.routeName: (context) => AuthScreen(),
        ProductContactFormScreen.routeName: (context) =>
            ProductContactFormScreen(null),
      },
    );
  }
}
