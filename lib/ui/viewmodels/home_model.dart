import 'package:Roylen/core/services/product_service.dart';
import 'package:stacked/stacked.dart';
// import '../../fake/products.dart';
import '../../core/services/service_locator.dart';
import '../../core/services/auth.dart';
import '../../core/models/product.dart';

class HomeModel extends BaseViewModel {
  // var pg = ProductGenerator();
  Auth _auth = locator<Auth>();
  ProductService _productService = locator<ProductService>();

  List<Product> _products = [];

  void init() async {
    _products = await _productService.getAllProducts(0, 0);
    notifyListeners();
  }

  Auth get auth => _auth;

  List<Product> get products => _products;

  // void navigateToDetail(BuildContext ctx, Product p) {
  //   Navigator.of(ctx).pushNamed()
  // }
}
