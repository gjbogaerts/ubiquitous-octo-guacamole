import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../core/services/service_locator.dart';
import '../../core/services/auth.dart';
import '../../core/services/validator_abstract.dart';
import '../../core/models/product.dart';
import '../../core/services/message_service.dart';

class ProductContactFormModel extends BaseViewModel {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Auth _auth = locator<Auth>();
  ValidatorAbstract _validator = locator<ValidatorAbstract>();
  MessageService _msgService = locator<MessageService>();

  String _msg;
  String _myError;
  String _result;

  GlobalKey<FormState> get formKey => _formKey;
  Auth get auth => _auth;
  ValidatorAbstract get validator => _validator;
  String get myError => _myError;
  String get result => _result;
  set msg(val) => _msg = val;

  void send(Product p) async {
    if (!_formKey.currentState.validate()) {
      _myError =
          'Je formulier bevat nog fouten. Wil je die herstellen voordat je op verzenden klikt?';
      notifyListeners();
      return;
    } else {
      _myError = null;
      notifyListeners();
    }
    _formKey.currentState.save();
    try {
      var result = await _msgService
          .save({'sender': _auth.user, 'receiver': p.creator, 'message': _msg});
      if (result != null) {
        _result = 'Je bericht is verzonden';
        _formKey.currentState.reset();
        notifyListeners();
      }
    } catch (err) {
      _myError = err.toString();
      notifyListeners();
    }
  }
}
