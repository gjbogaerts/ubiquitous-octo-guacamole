import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../theming/const_values.dart';
import '../viewmodels/home_model.dart';
import '../widgets/my_drawer.dart';
import 'auth_screen.dart';
import 'product_add_screen.dart';
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
      builder: (context, model, child) => Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/bgimage.jpeg'),
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Welkom bij Roylen'),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  if (model.auth.hasAuth) {
                    // Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushReplacementNamed(ProductAddScreen.routeName);
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Sorry!'),
                        content: SizedBox.fromSize(
                          size:
                              Size(MediaQuery.of(context).size.width * 0.8, 50),
                          // height: 200,
                          child: Text(
                              'Je moet ingelogd zijn om een product te kunnen aanbieden.'),
                        ),
                        actions: [
                          TextButton(
                            child: Text(
                              'Laat maar zitten',
                              textAlign: TextAlign.start,
                              style: TextStyle(color: ConstValues.accentColor),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: Text(
                              'Inloggen',
                              style: TextStyle(color: ConstValues.accentColor),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(AuthScreen.routeName);
                            },
                          )
                        ],
                      ),
                    );
                  }
                },
              )
            ],
          ),
          drawer: MyDrawer(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    controller: model.controller,
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
                              p.virtualPrice.toStringAsFixed(2),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          child: GestureDetector(
                            child: Hero(
                              tag: p.objectId,
                              child: FadeInImage(
                                placeholder:
                                    AssetImage('assets/images/image9.jpeg'),
                                image: NetworkImage(p.images[0]['url']),
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
                if (model.isLoading)
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (model.endIsReached)
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: Text('Geen producten meer'),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
