import 'package:Roylen/ui/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductForm(),
        ));
  }
}
