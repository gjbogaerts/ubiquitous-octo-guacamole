import 'package:flutter/material.dart';

import '../widgets/my_drawer.dart';
import '../widgets/product_form.dart';

class ProductAddScreen extends StatelessWidget {
  static const routeName = '/product-add';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bgimage.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Nieuw product'),
        ),
        drawer: MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductForm(),
        ),
      ),
    );
  }
}
