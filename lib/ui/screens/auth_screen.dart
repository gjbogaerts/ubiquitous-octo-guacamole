import 'package:Roylen/ui/widgets/background.dart';
import 'package:Roylen/ui/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../viewmodels/auth_model.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthModel>.reactive(
      viewModelBuilder: () => AuthModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Inloggen / registreren'),
        ),
        drawer: MyDrawer(),
        body: Stack(
          children: [
            Background(),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/image2.png',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    Form(
                      key: model.formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Gebruikersnaam'),
                            onChanged: (val) => model.username = val,
                            validator: (val) {
                              return model.validateUser(val);
                            },
                          ),
                          if (!model.isLogin)
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Email'),
                              onChanged: (val) => model.email = val,
                              validator: (val) {
                                return model.validateEmail(val);
                              },
                            ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Wachtwoord'),
                            onChanged: (val) => model.password = val,
                            obscureText: true,
                          ),
                          if (!model.isLogin)
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Herhaal je wachtwoord'),
                              onChanged: (val) => model,
                              validator: (val) {
                                return model.validatePassword(val);
                              },
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                child: Text(model.isLogin
                                    ? 'Nog geen account?'
                                    : 'Al een account?'),
                                onPressed: model.switchMode,
                              ),
                              ElevatedButton(
                                child: Text(
                                    model.isLogin ? 'Inloggen' : 'Registreren'),
                                onPressed: model.login,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
