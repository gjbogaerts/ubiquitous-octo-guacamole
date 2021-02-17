import 'package:Roylen/ui/widgets/background.dart';
import 'package:Roylen/ui/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodels/home_model.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeModel>.reactive(
      viewModelBuilder: () => HomeModel(),
      onModelReady: (model) {
        model.init();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Welkom bij Roylen'),
        ),
        drawer: MyDrawer(),
        body: Stack(
          children: [
            Background(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: model.products.length,
                itemBuilder: (BuildContext ctx, int idx) {
                  var p = model.products[idx];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GridTile(
                      header: GridTileBar(
                        title: Text(p.title),
                        subtitle: Text(p.description),
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
                            placeholder:
                                AssetImage('assets/images/image9.jpeg'),
                            image: NetworkImage(p.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              ProductDetailScreen.routeName,
                              arguments: p);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
