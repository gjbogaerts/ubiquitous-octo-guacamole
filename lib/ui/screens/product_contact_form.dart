import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../core/models/product.dart';
import '../theming/const_values.dart';
import '../viewmodels/product_contact_form_model.dart';

class ProductContactForm extends StatelessWidget {
  static const routeName = '/product-contact-form';
  final Product _product;

  ProductContactForm(this._product);
  @override
  Widget build(BuildContext context) {
    final _bottom = MediaQuery.of(context).viewInsets.bottom;

    return ViewModelBuilder<ProductContactFormModel>.reactive(
        builder: (context, model, child) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bgimage.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text('Zoek contact'),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, _bottom),
                  child: Column(
                    children: [
                      Text(
                        'Mail de eigenaar',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: ConstValues.appColor),
                      ),
                      Form(
                        key: model.formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Aan'),
                              readOnly: true,
                              // enabled: false,
                              initialValue: _product.creator.displayName,
                            ),
                            SizedBox(
                              height: ConstValues.divPadding,
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Van'),
                              readOnly: true,
                              // enabled: false,
                              initialValue: model.auth.user.displayName,
                            ),
                            SizedBox(
                              height: ConstValues.divPadding,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Je bericht',
                                hintText: 'Laat hier je bericht achter.',
                              ),
                              maxLines: 5,
                            ),
                            SizedBox(
                              height: ConstValues.divPadding,
                            ),
                            ElevatedButton(
                              onPressed: model.send,
                              child: Text('Verzenden'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
        viewModelBuilder: () => ProductContactFormModel());
  }
}



/**
 * 
 *  
 */