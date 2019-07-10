import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/redux/appstate.dart';
import 'auth_screen.dart';
import 'auth_view_model.dart';


class RegisterPage extends StatelessWidget {
  final GlobalKey<FormState> _formRegisterKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StoreConnector<AppState, AuthViewModel>(
          converter: (store) => AuthViewModel.fromStore(store),
          builder: (context, authViewModel) => _content(context, authViewModel),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, AuthViewModel authViewModel) {
    String email;
    String password;
    return Center(
        child: Form(
          key: _formRegisterKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please Type an email';
                  }
                },
                onSaved: (input) => email = input,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                obscureText: true,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please Type a password';
                  }
                },
                onSaved: (input) => password = input,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              RaisedButton(
                onPressed: () async {
                  _formRegisterKey.currentState.save();
                  await authViewModel.updateEmailPassword(email, password);
                  await authViewModel.registerFirebaseUser();
                  await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                child: Text('Register'),
              ),

            ],
          ),
        ));
  }
}