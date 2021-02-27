import 'package:flutter/material.dart';

import '../widgets/background.dart';
import '../widgets/my_drawer.dart';
import '../widgets/product_form.dart';

class ProductAddScreen extends StatelessWidget {
  static const routeName = '/product-add';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nieuw product'),
        ),
        drawer: MyDrawer(),
        body: Stack(
          children: [
            Background(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProductForm(),
            ),
          ],
        ));
  }
}
