import '../../fake/products.dart';
import 'package:stacked/stacked.dart';

class ProductDetailModel extends BaseViewModel {
  Product _product;

  ProductDetailModel(Product p) {
    this._product = p;
  }

  Product get product => _product;
}
