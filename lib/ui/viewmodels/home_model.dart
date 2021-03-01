import 'package:stacked/stacked.dart';
import '../../fake/products.dart';
import '../../core/services/service_locator.dart';
import '../../core/services/auth.dart';

class HomeModel extends BaseViewModel {
  var pg = ProductGenerator();
  Auth _auth = locator<Auth>();

  List<Product> _products = [];

  void init() {
    pg.generateProducts();
    _products = pg.products;
    notifyListeners();
  }

  Auth get auth => _auth;

  List<Product> get products => _products;

  // void navigateToDetail(BuildContext ctx, Product p) {
  //   Navigator.of(ctx).pushNamed()
  // }
}
