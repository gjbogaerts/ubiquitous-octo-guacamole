import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:stacked/stacked.dart';

import '../screens/auth_screen.dart';
import '../screens/home_screen.dart';
import '../theming/const_values.dart';
import '../viewmodels/product_form_model.dart';
import 'ad_categories.dart';

class ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductFormModel>.reactive(
      viewModelBuilder: () => ProductFormModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: model.formKey,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: ConstValues.divPadding,
                      ),
                      model.isFormValid
                          ? SizedBox.shrink()
                          : Text(
                              model.errorString,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: ConstValues.errorColor,
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
                      SizedBox(
                        height: ConstValues.divPadding,
                      ),
                      TextFormField(
                        maxLines: 5,
                        onSaved: (val) => model.description = val,
                        decoration: InputDecoration(labelText: 'Beschrijving'),
                        validator: (val) => model.validator.doValidations([
                          {
                            model.validator.notEmpty: [
                              [val],
                              {#msg: 'Dit veld is verplicht.'}
                            ]
                          }
                        ]),
                      ),
                      SizedBox(
                        height: ConstValues.divPadding,
                      ),
                      TextFormField(
                        onSaved: (val) => model.virtualPrice = val,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Aantal nix',
                          helperText: 'Alleen positieve gehele getallen',
                        ),
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
                              {#msg: 'Dit veld moet worden ingevuld.'}
                            ]
                          },
                          {
                            model.validator.minVal: [
                              [double.tryParse(val) ?? 0.0, 0.0],
                              {#msg: 'Alleen positieve bedragen alsjeblieft.'}
                            ]
                          }
                        ]),
                      ),
                      SizedBox(
                        height: ConstValues.divPadding,
                      ),
                      if (model.showPostalCodeField)
                        TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Postcode',
                                helperText:
                                    'Nodig om mensen in jouw buurt te attenderen'),
                            validator: (val) => model.validator.doValidations([
                                  {
                                    model.validator.notEmpty: [
                                      [val],
                                      {
                                        #msg:
                                            'Postcode is verplicht als je je locatie niet wilt delen'
                                      }
                                    ]
                                  }
                                ])),
                      SizedBox(
                        height: ConstValues.divPadding,
                      ),
                      DropdownButtonFormField(
                        items: model.getAgeItems(),
                        onChanged: (val) => model.ageCategory = val,
                        decoration: InputDecoration(
                          labelText: 'Voor welke leeftijdscategorie?',
                        ),
                      ),
                      SizedBox(
                        height: ConstValues.divPadding,
                      ),
                      AdCategories(
                        model.setMainCategory,
                        model.setSubCategory,
                        model.setSubSubCategory,
                        existingMainCat: model.mainCategory,
                        existingSubCat: model.subCategory,
                      ),
                      SizedBox(
                        height: ConstValues.divPadding,
                      ),
                      TextButton.icon(
                        icon: Icon(Icons.camera),
                        label: Text('Maak of kies een foto'),
                        onPressed: model.pickImage,
                      ),
                      SizedBox(
                        height: ConstValues.divPadding,
                      ),
                      if (model.images != null && model.images.length > 0)
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          children: List.generate(model.images.length, (index) {
                            Asset asset = model.images[index];
                            return AssetThumb(
                              asset: asset,
                              width: 100,
                              height: (100 /
                                      asset.originalWidth *
                                      asset.originalHeight)
                                  .round(),
                            );
                          }),
                        ),
                      SizedBox(
                        height: ConstValues.divPadding,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            child: Text('Verzenden'),
                            onPressed: () async {
                              if (model.auth.hasAuth) {
                                final bool result = await model.doSend();
                                if (result) {
                                  AlertDialog(
                                    title: Text('Succes'),
                                    content:
                                        Text('Je advertentie is geplaatst.'),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          'OK',
                                          style: TextStyle(
                                              color: ConstValues.accentColor),
                                        ),
                                        onPressed: () => Navigator.of(context)
                                            .pushReplacementNamed(
                                                HomeScreen.routeName),
                                      )
                                    ],
                                  );
                                } else {
                                  AlertDialog(
                                    title: Text('Helaas'),
                                    content: Text(
                                        'Er is helaas iets mis gegaan tijdens het aanmaken van uw advertentie. Probeert u het later nog een keer?'),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          'OK',
                                          style: TextStyle(
                                              color: ConstValues.accentColor),
                                        ),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      )
                                    ],
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          if (!model.auth.hasAuth)
            AlertDialog(
              title: Text('Inloggen'),
              content: Text(
                  'Je moet ingelogd zijn om een advertentie te kunnen aanmaken.'),
              actions: [
                TextButton(
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: ConstValues.accentColor,
                    ),
                  ),
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(AuthScreen.routeName),
                )
              ],
            )
          // Center(
          //   child: Container(
          //     width: MediaQuery.of(context).size.width * 0.5,
          //     height: MediaQuery.of(context).size.height * 0.3,
          //     child: Card(
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(18.0)),
          //       child: Center(
          //         child: Text(
          //             'Je moet ingelogd zijn om een advertentie te kunnen maken.'),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
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
