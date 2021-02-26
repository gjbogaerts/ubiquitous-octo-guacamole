import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../models/product.dart';
import 'image_service.dart';
import 'my_logger.dart';
import 'product_service.dart';
import 'service_locator.dart';
import 'image_handler.dart';

class ProductServiceImp extends ProductService {
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
    _logger.d('Save | $vals');
    var product = Product();
    product.set('title', vals['title']);
    product.set('description', vals['description']);
    product.set('virtualPrice', vals['virtualPrice']);
    product.set('mainCategory', vals['mainCategory']);
    product.set('subCategory', vals['subCategory']);
    product.set('subSubCategory', vals['subSubCategory']);
    ParseGeoPoint loc =
        ParseGeoPoint(latitude: vals['latitude'], longitude: vals['longitude']);
    product.set('location', loc);
    product.set('postalCode', vals['postalCode']);

    List<File> images =
        await _imageHandler.convertListAssetToListFile(vals['images']);
    List<ParseFile> uploads = _imageService.convertToParseFiles(images);
    product.set('images', uploads);

    ParseResponse response = await product.save();
    _logger.d(response.statusCode);
    _logger.d(response.result);
    _logger.d(response.results);
    _logger.d(response.error);

    return product;
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
}
