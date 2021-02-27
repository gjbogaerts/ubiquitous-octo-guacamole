import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/models/cats.dart';
import '../../core/models/product.dart';
import '../../core/services/auth.dart';
import '../../core/services/location.dart';
import '../../core/services/my_logger.dart';
import '../../core/services/product_service.dart';
import '../../core/services/service_locator.dart';
import '../../core/services/validator_abstract.dart';
import '../theming/custom_colors.dart';

class ProductFormModel extends BaseViewModel {
  final Auth _auth = locator<Auth>();
  final Location _geoLocator = locator<Location>();
  final ValidatorAbstract _validator = locator<ValidatorAbstract>();
  final ProductService _productService = locator<ProductService>();
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
  List<Asset> _images;

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
      final Position position = await _geoLocator.determineLocation();
      // _logger.d('initializing model | $position');
      _longitude = position.longitude;
      _latitude = position.latitude;
    } catch (err) {
      _logger.d('error: ${err.toString()}');
      _showPostalCodeField = true;
      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    // _logger.d('pickImage | ');
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
          maxImages: 5,
          enableCamera: true,
          cupertinoOptions: CupertinoOptions(
            backgroundColor: CustomColors.appColor.toString(),
          ),
          materialOptions: MaterialOptions());
      _images = resultList;
      notifyListeners();
      // _logger.d(_images);
    } catch (err) {
      _logger.d(err);
    }
  }

  List<Asset> get images => _images;

  Future<bool> doSend() async {
    if (!_formKey.currentState.validate()) {
      // _logger.d('doSend: $title invalid');
      _isFormValid = false;
      _errorString =
          'Je formulier is niet juist ingevuld. Check de fouten en probeer het opnieuw.';
      notifyListeners();
      return false;
    } else {
      _errorString = '';
      _isFormValid = true;
      notifyListeners();
    }
    _formKey.currentState.save();
    Product p = await _productService.save({
      'creator': _auth.user,
      'title': title,
      'description': description,
      'virtualPrice': _virtualPrice,
      'longitude': _longitude,
      'latitude': _latitude,
      'ageCategory': ageCategory,
      'mainCategory': mainCategory,
      'subCategory': subCategory,
      'subSubCategory': subSubCategory,
      'postalCode': postalCode ?? '',
      'images': _images
    });

    notifyListeners();
    if (p != null) {
      return true;
    } else {
      return false;
    }
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

  bool get showPostalCodeField => _showPostalCodeField;
}
