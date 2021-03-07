import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/product.dart';
import '../../core/services/auth.dart';
import '../../core/services/product_service.dart';
// import '../../fake/products.dart';
import '../../core/services/service_locator.dart';

class HomeModel extends BaseViewModel {
  // var pg = ProductGenerator();
  Auth _auth = locator<Auth>();
  ProductService _productService = locator<ProductService>();
  ScrollController _controller = ScrollController();
  int _currentPage = 0;
  bool _endIsReached = false;
  bool _isLoading = true;
  List<Product> _products = [];

  Future<void> init() async {
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent &&
          !_endIsReached) {
        print('we reached the end!');
        _currentPage++;
        searchNext(_currentPage);
      }
    });
    return await searchNext(_currentPage);
  }

  @override
  dispose() {
    _controller.removeListener(() {
      print('Listener removed.');
    });
    super.dispose();
  }

  Future<void> searchNext(int page) async {
    _isLoading = true;
    notifyListeners();
    var moreProducts = await _productService.getAllProducts(page);
    if (moreProducts.length == 0) {
      _endIsReached = true;
    } else {
      _products.addAll(moreProducts);
    }
    _isLoading = false;
    notifyListeners();
  }

  Auth get auth => _auth;

  List<Product> get products => _products;

  ScrollController get controller => _controller;

  bool get endIsReached => _endIsReached;

  bool get isLoading => _isLoading;
}
