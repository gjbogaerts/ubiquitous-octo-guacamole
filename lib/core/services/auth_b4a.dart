import 'my_logger.dart';
import 'package:logger/logger.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../models/user.dart';
import 'auth.dart';

class AuthB4A extends Auth {
  User _user;
  // ignore: unused_field
  Logger _log = getLogger(' AuthB4A');

  AuthB4A() {
    tryAutoLogin();
  }

  @override
  Future<bool> login(String username, String password) async {
    try {
      var user = User(username, password, username);
      final response = await user.login();
      if (response.success) {
        var result = response.results;
        _user = result[0] as User;
        _log.d(_user);
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      var user = await ParseUser.currentUser();
      // var response = await user
      user.logout();
      _user = null;
      return true;
      // print(user.toString());
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<bool> requestPasswordReset(String email) async {
    try {
      var user = ParseUser('', '', email);
      var response = await user.requestPasswordReset();
      print(response.result);
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  @override
  Future<bool> register(String username, String password, String email) async {
    try {
      var user = ParseUser.createUser(email, password, email)
        ..set<int>('nix', 100)
        ..set<String>('profilePicUri', '')
        ..set<String>('displayName', username);

      var response = await user.signUp();
      if (response.success) {
        // user.save();
        return true;
      } else {
        return false;
      }
    } catch (err) {
      throw (err);
    }
  }

  User get user => _user;
  bool get hasAuth => _user != null;

  Future<void> tryAutoLogin() async {
    try {
      _user = await ParseUser.currentUser();
      // var prefs = await SharedPreferences.getInstance();
      // String userString = prefs.get('flutter_parse_sdk_user');
      // _user = User.fromJson(userString);
    } catch (err) {
      // _log.d('De fout is: $err');
      // no action necessary...
    }
  }
}
