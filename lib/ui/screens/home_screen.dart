import 'package:flutter/material.dart';
import '../../fake/products.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    var pg = ProductGenerator();
    pg.generateProducts();
    List<Product> _products = pg.products;

    return Scaffold(
      appBar: AppBar(
        title: Text('Welkom bij Roylen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 2 / 3,
          ),
          itemCount: 100,
          itemBuilder: (BuildContext ctx, int idx) {
            Product p = _products[idx];
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GridTile(
                header: GridTileBar(
                  title: Text(p.title),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                footer: GridTileBar(
                  title: Text(
                    p.price.toStringAsFixed(2),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: GestureDetector(
                  child: Hero(
                    tag: p.id,
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/image9.jpeg'),
                      image: NetworkImage(p.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    return;
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
