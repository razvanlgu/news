import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/resources/constants.dart';
import 'package:news/resources/keys.dart';
import 'auth_view_model.dart';


class RegisterPage extends StatelessWidget {
  static final GlobalKey<FormState> _formRegisterKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,

      ),
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RaisedButton(
                    onPressed: () async {
                      _formRegisterKey.currentState.save();
                      await authViewModel.updateEmailPassword(email, password);
                      await authViewModel.registerFirebaseUser();
                      await Keys.navKey.currentState.pushReplacementNamed(Routes.login);
                    },
                    child: Text('Register'),
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}