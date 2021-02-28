import '../models/product.dart';

abstract class ProductService {
  Future<Product> save(Map<String, dynamic> p);
  Future<Product> update(Map<String, dynamic> p);
  Future<Product> delete(String id);
  Future<Product> readOne(String id);
  Future<List<Product>> search(Map<String, dynamic> terms);
  Future<List<Product>> getAllProducts(int startIndex, int page);
}
