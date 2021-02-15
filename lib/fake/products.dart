import 'package:faker/faker.dart';

class ProductGenerator {
  Faker f = Faker();

  List<Product> _products = [];

  void generateProducts() {
    for (var i = 0; i < 100; i++) {
      String kitchen = faker.food.cuisine();
      String dish = faker.food.dish();
      _products.add(
        Product(
          faker.guid.guid(),
          kitchen,
          faker.lorem.sentences(3).join('. '),
          faker.image.image(width: 300, height: 200, keywords: [kitchen, dish]),
          faker.randomGenerator.decimal(),
        ),
      );
    }
  }

  List<Product> get products => _products;
}

class Product {
  String id;
  String title;
  String description;
  String image;
  double price;

  Product(this.id, this.title, this.description, this.image, this.price);
}
