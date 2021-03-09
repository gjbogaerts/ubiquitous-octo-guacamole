import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../theming/const_values.dart';
import '../viewmodels/product_detail_model.dart';
import 'product_contact_form_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    final _bottom = MediaQuery.of(context).viewInsets.bottom;

    return ViewModelBuilder<ProductDetailModel>.reactive(
      viewModelBuilder: () => ProductDetailModel(args),
      builder: (context, model, child) {
        if (model.showError)
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Fout'),
                content: Container(
                  height: 200,
                  child: Center(child: Text(model.myError)),
                ),
                actions: [
                  TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: Text(
                      'OK',
                      style: TextStyle(color: ConstValues.accentColor),
                    ),
                  ),
                ],
              ),
            );
          });

        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/bgimage.jpeg'),
            fit: BoxFit.cover,
          )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(model.product.title),
            ),
            body: Padding(
              padding:
                  EdgeInsets.only(left: 8, top: 8, right: 8, bottom: _bottom),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      model.product.images[0]['url'],
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
                    Text(
                        'Advertentie geplaatst door ${model.product.creator.displayName} op ${model.formatter.formatDate(model.product.createdAt)}'),
                    Divider(
                      height: 50,
                      color: ConstValues.appColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${(model.product.virtualPrice)} nix',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            model.contact();
                            if (model.showContactForm) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductContactFormScreen(model.product),
                                ),
                              );
                            }
                          },
                          child: Text('Contact'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
