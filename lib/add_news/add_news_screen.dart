import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';

import 'add_news_view_model.dart';

class AddNewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    _screenWidth = MediaQuery.of(context).size.width;
//    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StoreConnector<AppState, AddNewsViewModel>(
        converter: (store) => AddNewsViewModel.fromStore(store),
        builder: (context, addNewsViewModel) => _content(context, addNewsViewModel),
//        onInit: _onInit,
      ),
    );
  }

  /**
   * Get all the news
   */
  _onInit(Store<AppState> store) {
  }

  Widget _content(BuildContext context, AddNewsViewModel addNewsViewModel) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        MyAppBar(),
        AddNewsForm(addNewsViewModel),
      ],
    );
  }
}

// AppBar
class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed:() => Navigator.pop(context),
      ),
    );
  }
}

// News list
class AddNewsForm extends StatelessWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddNewsViewModel model;
  AddNewsForm(this.model);

  String _title;
  String password;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Please Type a title';
                      }
                    },
                    onSaved: (input) => _title = input,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder()
                    ),
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
                      _formKey.currentState.save();
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
