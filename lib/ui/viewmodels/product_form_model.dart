import '../../core/services/validator_abstract.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/services/auth.dart';
import '../../core/services/location.dart';
import '../../core/services/my_logger.dart';
import '../../core/services/service_locator.dart';
import '../../core/models/cats.dart';

class ProductFormModel extends BaseViewModel {
  final Auth _auth = locator<Auth>();
  final Location _location = locator<Location>();
  final ValidatorAbstract _validator = locator<ValidatorAbstract>();
  final _formKey = GlobalKey<FormState>();
  final _logger = getLogger('ProductFormModel');
  // final _location = Geolocation.
  bool _isFormValid = true;
  bool _showPostalCodeField = false;
  bool showSubCat = false;
  bool showSubSubCat = false;
  String _errorString;

  String title;
  String description;
  int _virtualPrice;
  String mainCategory;
  String subCategory;
  List<DropdownMenuItem> subCats;
  String subSubCategory;
  List<DropdownMenuItem> subSubCats;
  String ageCategory;
  double _latitude;
  double _longitude;
  String postalCode;

  bool get isFormValid => _isFormValid;
  String get errorString => _errorString;
  ValidatorAbstract get validator => _validator;

  Auth get auth => _auth;
  GlobalKey get formKey => _formKey;

  set virtualPrice(String p) {
    _virtualPrice = int.tryParse(p) ?? 0;
  }

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

  List getAgeItems() {
    return <String>['0-1', '2-4', '5-6', '7-10', '10-12', '12-16', '0-16']
        .map<DropdownMenuItem<String>>(
            (String e) => DropdownMenuItem<String>(value: e, child: Text(e)))
        .toList();
  }

  void setMainCategory(String cat) {
    // subCats = [];
    // subCategory = null;
    // notifyListeners();
    mainCategory = cat;
    subCats = _getSubCategories();
    showSubCat = true;
    notifyListeners();
  }

  void setSubCategory(String cat) {
    showSubSubCat = false;
    notifyListeners();
    if (cat == null || cat.isEmpty) {
      return;
    }
    subCategory = cat;
    showSubSubCat = true;
    notifyListeners();
  }

  void setSubSubCategory(String cat) {
    if (cat == null || cat.isEmpty) {
      return;
    }
    subSubCategory = cat;
    notifyListeners();
  }

  List<DropdownMenuItem> getMainCategories() {
    var cats = Cats.mainCategoriesOnly;
    // _logger.d('getMainCategories | $cats');
    return cats
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ))
        .toList();
  }

  List<DropdownMenuItem> _getSubCategories() {
    var cats = Cats.getSubCategories(mainCategory);
    // _logger.d('getSubCategories | $cats');
    return cats.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList();
  }

  List<DropdownMenuItem> getSubSubCategories() {
    var cats = Cats.getSubSubCategories(mainCategory, subCategory);
    cats.insert(0, 'Kies een item');
    // _logger.d('getSubSubCategories | $cats');
    return cats
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ))
        .toList();
  }
}
