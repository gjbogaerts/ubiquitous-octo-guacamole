import 'package:Roylen/ui/theming/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodels/product_form_model.dart';
import './ad_categories.dart';

class ProductForm extends StatelessWidget {
  /*
   * TODO: use multi_image_picker
   */
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
                        TextFormField(
                          maxLines: 5,
                          onSaved: (val) => model.description = val,
                          decoration:
                              InputDecoration(labelText: 'Beschrijving'),
                          validator: (val) => model.validator.doValidations([
                            {
                              model.validator.notEmpty: [
                                [val],
                                {#msg: 'Dit veld is verplicht.'}
                              ]
                            }
                          ]),
                        ),
                        TextFormField(
                          onSaved: (val) => model.virtualPrice = val,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Aantal nix'),
                          validator: (val) => model.validator.doValidations([
                            {
                              model.validator.intOnly: [
                                [val],
                                {#msg: 'Alleen nummers alsjeblieft.'}
                              ]
                            },
                            {
                              model.validator.notEmpty: [
                                [val],
                              ]
                            }
                          ]),
                        ),
                        DropdownButtonFormField(
                          items: model.getAgeItems(),
                          onChanged: (val) => model.ageCategory = val,
                          decoration: InputDecoration(
                            labelText: 'Voor welke leeftijdscategorie?',
                          ),
                        ),
                        AdCategories(
                          model.setMainCategory,
                          model.setSubCategory,
                          model.setSubSubCategory,
                          existingMainCat: model.mainCategory,
                          existingSubCat: model.subCategory,
                        ),
                        SizedBox(height: 20),
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
