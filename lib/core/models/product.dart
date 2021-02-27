import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import './user.dart';

class Product extends ParseObject implements ParseCloneable {
  Product() : super(_keyTableName);

  Product.clone() : this();

  @override
  clone(Map map) => Product.clone()..fromJson(map);

  static const String _keyTableName = 'Product';
  static const String _keyCreator = 'creator';
  static const String _keyTitle = 'title';
  static const String _keyDescription = 'description';
  static const String _keyVirtualPrice = 'virtualPrice';
  static const String _keyMainCat = 'mainCategory';
  static const String _keySubCat = 'subCategory';
  static const String _keySubSubCat = 'subSubCategory';
  static const String _keyLocation = 'location';
  static const String _keyPostalCode = 'postalCode';
  static const String _keyImages = 'images';

  User get creator => get<User>(_keyCreator);
  set creator(User u) => set<User>(_keyCreator, u);
  String get title => get<String>(_keyTitle);
  set title(String title) => set<String>(_keyTitle, title);
  String get description => get<String>(_keyDescription);
  set description(String description) =>
      set<String>(_keyDescription, description);
  int get virtualPrice => get<int>(_keyVirtualPrice);
  set virtualPrice(int virtualPrice) =>
      set<int>(_keyVirtualPrice, virtualPrice);
  String get mainCategory => get<String>(_keyMainCat);
  set mainCategory(String mainCategory) =>
      set<String>(_keyMainCat, mainCategory);
  String get subCategory => get<String>(_keySubCat);
  set subCategory(String subCategory) => set<String>(_keySubCat, subCategory);
  String get subSubCategory => get<String>(_keySubSubCat);
  set subSubCategory(String subCategory) =>
      set<String>(_keySubSubCat, subSubCategory);
  ParseGeoPoint get location => get<ParseGeoPoint>(_keyLocation);
  set location(ParseGeoPoint location) =>
      set<ParseGeoPoint>(_keyLocation, location);
  String get postalCode => get<String>(_keyPostalCode);
  set postalCode(String postalCode) => set<String>(_keyPostalCode, postalCode);
  List get images => get<List>(_keyImages);
  set images(List images) => set<List>(_keyImages, images);
}
