import 'package:Roylen/ui/viewmodels/product_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../fake/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final Product args = ModalRoute.of(context).settings.arguments;

    return ViewModelBuilder<ProductDetailModel>.reactive(
      viewModelBuilder: () => ProductDetailModel(args),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(model.product.title),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  model.product.image,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
                Text(
                  model.product.title,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  model.product.description,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'nix ${(model.product.price * 100).toStringAsFixed(2)}'),
                    Text(model.product.id),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
