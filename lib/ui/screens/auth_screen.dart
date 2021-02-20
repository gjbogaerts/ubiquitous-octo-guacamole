import 'package:Roylen/ui/screens/home_screen.dart';
import 'package:Roylen/ui/widgets/background.dart';
import 'package:Roylen/ui/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../viewmodels/auth_model.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  String _showDialogText(bool result, bool isLogin) {
    if (isLogin && result) {
      return 'Je bent nu ingelogd.';
    } else if (!isLogin && result) {
      return 'Je bent succesvol geregistreerd. Je ontvangt een email om je registratie te bevestigen. Daarna kun je inloggen.';
    } else if (isLogin && !result) {
      return 'Helaas, er is iets mis gegaan tijdens het inloggen.';
    } else if (!isLogin && !result) {
      return 'Helaas, er is iets mis gegaan tijdens de registratie.';
    } else {
      return null;
    }
  }

  void _showDialog(BuildContext context, bool result, bool isLogin) async {
    await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(result ? 'Succes' : 'Helaas'),
              content: SingleChildScrollView(
                child: Center(
                  child: Text(_showDialogText(result, isLogin)),
                ),
              ),
              actions: [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ));
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthModel>.reactive(
      viewModelBuilder: () => AuthModel(),
      builder: (context, model, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (model.loginResult != null) {
            _showDialog(context, model.loginResult, model.isLogin);
          }
        });

        return Scaffold(
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
                            if (!model.isLogin)
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Gebruikersnaam'),
                                onChanged: (val) => model.username = val,
                                validator: (val) {
                                  return model.validateUser(val);
                                },
                              ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Email'),
                              onChanged: (val) => model.email = val,
                              validator: (val) {
                                return model.validateEmail(val);
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Wachtwoord',
                                suffixIcon: IconButton(
                                  icon: Icon(model.passwordHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: model.togglePasswordHidden,
                                ),
                              ),
                              onChanged: (val) => model.password = val,
                              obscureText: model.passwordHidden,
                            ),
                            if (!model.isLogin)
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Herhaal je wachtwoord',
                                    suffixIcon: IconButton(
                                      icon: Icon(model.passwordHidden
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: model.togglePasswordHidden,
                                    )),
                                onChanged: (val) => model.checkPassword = val,
                                obscureText: model.passwordHidden,
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
                                  child: Text(model.isLogin
                                      ? 'Inloggen'
                                      : 'Registreren'),
                                  onPressed: model.login,
                                ),
                              ],
                            ),
                            if (model.isLogin)
                              Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextButton(
                                    child: Text('Wachtwoord vergeten?'),
                                    onPressed: model.lostPassword,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
