import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/product.dart';
import '../theming/const_values.dart';
import '../viewmodels/product_contact_form_model.dart';
import '../widgets/error_message.dart';

class ProductContactFormScreen extends StatelessWidget {
  static const routeName = '/product-contact-form-screen';
  final Product _product;

  final _snackBar = SnackBar(
    backgroundColor: ConstValues.appColor,
    content: Text(
      'Je boodschap is verzonden.',
      style: TextStyle(
        color: ConstValues.accentColor,
      ),
    ),
  );

  ProductContactFormScreen(this._product);
  @override
  Widget build(BuildContext context) {
    final _bottom = MediaQuery.of(context).viewInsets.bottom;

    return ViewModelBuilder<ProductContactFormModel>.reactive(
      builder: (context, model, child) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (model.result != null)
            ScaffoldMessenger.of(context).showSnackBar(_snackBar);
        });

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
              title: Text('Zoek contact'),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, _bottom),
                  child: Form(
                    key: model.formKey,
                    child: Column(
                      children: [
                        Text(
                          'Betreft: ${_product.title}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: ConstValues.appColor),
                        ),
                        SizedBox(
                          height: ConstValues.divPadding,
                        ),
                        if (model.myError != null) ErrorMessage(model.myError),
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
                            helperText: 'Laat hier je bericht achter.',
                          ),
                          maxLines: 5,
                          validator: (val) => model.validator.notEmpty(val),
                          onSaved: (val) => model.msg = val,
                        ),
                        SizedBox(
                          height: ConstValues.divPadding,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: Navigator.of(context).pop,
                                child: Text('Laat maar zitten')),
                            ElevatedButton(
                              onPressed: () => model.send(_product),
                              child: Text('Verzenden'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => ProductContactFormModel(),
    );
  }
}



/**
 * 
 *  
 */