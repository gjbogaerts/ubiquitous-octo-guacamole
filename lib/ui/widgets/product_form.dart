import 'package:Roylen/ui/theming/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodels/product_form_model.dart';

class ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductFormModel>.reactive(
        viewModelBuilder: () => ProductFormModel(),
        onModelReady: (model) => model.initialize(),
        builder: (context, model, child) => SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: model.formKey,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        model.isFormValid
                            ? SizedBox.shrink()
                            : Text(
                                model.errorString,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: CustomColors.errorColor,
                                    ),
                              ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Titel'),
                          validator: (val) {
                            return model.validator.doValidations(
                              [
                                {
                                  model.validator.notEmpty: [
                                    [val],
                                    {#msg: 'Je moet hier een waarde invullen.'}
                                  ]
                                },
                                {
                                  model.validator.minLength: [
                                    [val, 5],
                                    {#msg: 'Minimaal vijf tekens.'}
                                  ]
                                },
                                {
                                  model.validator.maxLength: [
                                    [val, 50],
                                    {#msg: 'Maximaal vijftig tekens.'}
                                  ]
                                }
                              ],
                            );
                          },
                          onSaved: (val) => model.title = val,
                        ),
                        ElevatedButton(
                          child: Text('Verzenden'),
                          onPressed: model.doSend,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}

/*
    'title': '',
    'description': '',
    'virtualPrice': 0,
    'mainCategory': '',
    'subCategory': '',
    'subSubCategory': '',
    'ageCategory': '0-16',
    'picture': [],
    'latitude': '',
    'longitude': ''
  */
