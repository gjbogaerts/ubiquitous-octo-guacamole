import 'package:flutter/material.dart';

import '../screens/auth_screen.dart';
import '../screens/home_screen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Text('Welkom bij Roylen'),
          ),
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
          )
        ],
      ),
    );
  }
}
