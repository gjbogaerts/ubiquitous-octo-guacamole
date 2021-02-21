import 'package:flutter/material.dart';

import '../screens/auth_screen.dart';
import '../screens/home_screen.dart';
import '../../core/services/service_locator.dart';
import '../../core/services/auth.dart';

class MyDrawer extends StatelessWidget {
  final Auth _auth = locator<Auth>();

  @override
  Widget build(BuildContext context) {
    String _welcome() {
      return _auth.hasAuth
          ? 'Welkom bij Roylen, ${_auth.user.displayName}'
          : 'Welkom bij Roylen';
    }

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Text(_welcome()),
          ),
          if (!_auth.hasAuth)
            ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text('Inloggen of registreren'),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(AuthScreen.routeName),
            ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Beginscherm'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(HomeScreen.routeName),
          ),
          if (_auth.hasAuth)
            ListTile(
              leading: Icon(Icons.supervised_user_circle_outlined),
              title: Text('Uitloggen'),
              onTap: () {
                _auth.logout();
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
              },
            )
        ],
      ),
    );
  }
}
