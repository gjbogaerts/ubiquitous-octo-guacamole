import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../fake/products.dart';

class HomeModel extends BaseViewModel {
  var pg = ProductGenerator();

  List<Product> _products = [];

  void init() {
    pg.generateProducts();
    _products = pg.products;
    notifyListeners();
  }

  List<Product> get products => _products;

  // void navigateToDetail(BuildContext ctx, Product p) {
  //   Navigator.of(ctx).pushNamed()
  // }
}
