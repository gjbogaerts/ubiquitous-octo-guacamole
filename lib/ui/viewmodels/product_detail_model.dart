import 'package:stacked/stacked.dart';

import '../../core/models/product.dart';
import '../../core/services/formatter_abstract.dart';
import '../../core/services/service_locator.dart';
import '../../core/services/auth.dart';

class ProductDetailModel extends BaseViewModel {
  Product _product;
  AbstractFormatter _formatter = locator<AbstractFormatter>();
  Auth _auth = locator<Auth>();
  bool _showError = false;
  bool _showContactForm = false;
  String _myError;

  ProductDetailModel(Product p) {
    this._product = p;
  }

  Product get product => _product;
  AbstractFormatter get formatter => _formatter;
  Auth get auth => _auth;
  String get myError => _myError;
  bool get showError => _showError;
  bool get showContactForm => _showContactForm;

  void contact() {
    if (!_auth.hasAuth) {
      _showError = true;
      _myError =
          'Je moet ingelogd zijn om contact te kunnen opnemen met de aanbieder.';
    } else {
      _showError = false;
      _showContactForm = true;
    }
    notifyListeners();
  }
}
