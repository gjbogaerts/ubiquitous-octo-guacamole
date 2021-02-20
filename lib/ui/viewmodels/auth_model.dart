import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../../core/services/auth.dart';
import '../../core/services/service_locator.dart';

class AuthModel extends BaseViewModel {
  String _username;
  String _email;
  String _password;
  // ignore: unused_field
  String _checkPassword;
  bool _isLogin = true;
  bool _isFormValid;
  bool _passwordHidden = true;
  bool _loginResult;

  final _formKey = GlobalKey<FormState>();
  Auth _auth = locator<Auth>();

  set username(String val) => _username = val;
  set email(String val) => _email = val;
  set password(String val) => _password = val;
  set checkPassword(String val) => _checkPassword = val;

  void lostPassword() {
    _auth.requestPasswordReset(_email);
  }

  void login() async {
    if (!_formKey.currentState.validate()) {
      _isFormValid = false;
      notifyListeners();
      return;
    } else {
      _isFormValid = true;
      notifyListeners();
    }
    if (_isLogin) {
      // print('logging in with $_username and $_password');
      _loginResult = await _auth.login(_email, _password);
    } else {
      _loginResult = await _auth.register(_username, _password, _email);
      // print(
      // 'registering with $_username, $_email, $_password, $_checkPassword');
    }
    notifyListeners();
  }

  String validateUser(String val) {
    if (val.length < 5) {
      return 'Ten minste vijf lettertekens.';
    } else {
      return null;
    }
  }

  String validatePassword(String val) {
    if (val != _password) {
      return 'Je wachtwoorden zijn niet hetzelfde.';
    } else {
      return null;
    }
  }

  String validateEmail(String val) {
    RegExp exp = new RegExp(
        // r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
        caseSensitive: false);
    if (!exp.hasMatch(val)) {
      return 'Dit is geen geldig email-adres.';
    } else {
      return null;
    }
  }

  bool get isLogin => _isLogin;
  GlobalKey get formKey => _formKey;
  bool get isFormValid => _isFormValid;
  bool get loginResult => _loginResult;
  bool get passwordHidden => _passwordHidden;

  void switchMode() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  void togglePasswordHidden() {
    _passwordHidden = !_passwordHidden;
    notifyListeners();
  }
}
