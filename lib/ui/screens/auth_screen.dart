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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/image1.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              )
            ],
          ),
        ),
      ),
    );
  }
}
