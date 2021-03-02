import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../exceptions/parse_object_exception.dart';
import '../models/product.dart';
import 'image_handler.dart';
import 'image_service.dart';
import 'my_logger.dart';
import 'product_service.dart';
import 'service_locator.dart';

class ProductServiceImp extends ProductService {
  // ignore: unused_field
  var _logger = getLogger('ProductServiceImp');
  var _imageService = locator<ImageService>();
  var _imageHandler = ImageHandler();
  @override
  Future<Product> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Product> readOne(String id) {
    // TODO: implement readOne
    throw UnimplementedError();
  }

  @override
  Future<Product> save(Map<String, dynamic> vals) async {
    try {
      var product = Product();
      product.set('creator', vals['creator']);
      product.set('title', vals['title']);
      product.set('description', vals['description']);
      product.set('virtualPrice', vals['virtualPrice']);
      product.set('mainCategory', vals['mainCategory']);
      product.set('subCategory', vals['subCategory']);
      product.set('subSubCategory', vals['subSubCategory']);
      ParseGeoPoint loc = ParseGeoPoint(
          latitude: vals['latitude'] ?? 0.0,
          longitude: vals['longitude'] ?? 0.0);
      product.set('location', loc);
      product.set('postalCode', vals['postalCode']);

      List<File> images =
          await _imageHandler.convertListAssetToListFile(vals['images']);
      List<ParseFile> uploads = _imageService.convertToParseFiles(images);
      product.set('images', uploads);
      await product.save();
      return product;
    } catch (err) {
      throw ParseObjectException(err);
    }
  }

  @override
  Future<List<Product>> search(Map<String, dynamic> terms) {
    // TODO: implement search
    throw UnimplementedError();
  }

  @override
  Future<Product> update(Map<String, dynamic> p) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getAllProducts(int startIndex, int page) async {
    QueryBuilder<Product> query = QueryBuilder<Product>(Product())
      ..includeObject(['creator']);
    final ParseResponse response = await query.query();
    List<Product> products = response.results.cast<Product>();
    return products;
  }
}
