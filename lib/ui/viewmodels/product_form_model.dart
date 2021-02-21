import '../../core/services/validator_abstract.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/services/auth.dart';
import '../../core/services/location.dart';
import '../../core/services/my_logger.dart';
import '../../core/services/service_locator.dart';

class ProductFormModel extends BaseViewModel {
  final Auth _auth = locator<Auth>();
  final Location _location = locator<Location>();
  final ValidatorAbstract _validator = locator<ValidatorAbstract>();
  final _formKey = GlobalKey<FormState>();
  final _logger = getLogger('ProductFormModel');
  // final _location = Geolocation.
  bool _isFormValid = true;
  bool _showPostalCodeField = false;
  String _errorString;

  String title;
  String description;
  int virtualPrice;
  String mainCategory;
  String subCategory;
  String subSubCategory;
  String ageCategory;
  double _latitude;
  double _longitude;
  String postalCode;

  bool get isFormValid => _isFormValid;
  String get errorString => _errorString;
  ValidatorAbstract get validator => _validator;

  Auth get auth => _auth;
  GlobalKey get formKey => _formKey;

  void initialize() async {
    try {
      final location = await _location.determineLocation();

      _logger.d('initializing model | $location');
      _longitude = location.longitude;
      _latitude = location.latitude;
    } catch (err) {
      _showPostalCodeField = true;
      notifyListeners();
    }
  }

  void doSend() {
    _logger.d('doSend | called');
    if (!_formKey.currentState.validate()) {
      _logger.d('doSend: $title invalid');
      _isFormValid = false;
      _errorString =
          'Je formulier is niet juist ingevuld. Check de fouten en probeer het opnieuw.';
      notifyListeners();
      return;
    } else {
      _errorString = '';
      _isFormValid = true;
      notifyListeners();
    }
    _formKey.currentState.save();

    _logger.d('doSend: $title valid');
    notifyListeners();
  }
}
