import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/resources/constants.dart';
import 'package:news/resources/keys.dart';

import 'auth_view_model.dart';


class LoginScreen extends StatelessWidget {
 static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsetsDirectional.only(top: 20.0),
                  child: TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Please Type an email';
                      } else {
                        return '';
                      }
                    },
                    onSaved: (input) => email = input,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        hasFloatingPlaceholder: false
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.only(top: 15.0),
                  child: TextFormField(
                      obscureText: true,
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Please Type a password';
                        } else {
                          return '';
                        }
                      },
                    onSaved: (input) => password = input,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hasFloatingPlaceholder: false,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RaisedButton(
                    onPressed: () async {
                      _formKey.currentState.save();
                      await authViewModel.updateEmailPassword(email, password);
                      await authViewModel.getFirebaseUser();

                   if(authViewModel.firebaseUser == null){
                        _showAlertDraw(context);
                   }

                    },
                    child: Text('Log in')

                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Keys.navKey.currentState.pushReplacementNamed(
                        Routes.register);
                  },
                  child: Text('Register'),
                )
              ],
            ),
          ),
        ));
  }
 Future _showAlertDraw(BuildContext context) async {
   return  showDialog(
       barrierDismissible: false,
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(

           title:  Text('Wrong email or password'),
           actions: <Widget>[
             new FlatButton(onPressed: () {
               Navigator.pop(context);

             },
                 child:  Text('Try again'))
           ],
         );}

   );
 }
}