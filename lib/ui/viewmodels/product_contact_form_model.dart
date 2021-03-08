import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../core/services/service_locator.dart';
import '../../core/services/auth.dart';

class ProductContactFormModel extends BaseViewModel {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Auth _auth = locator<Auth>();

  GlobalKey<FormState> get formKey => _formKey;
  Auth get auth => _auth;

  void send() {}
}
