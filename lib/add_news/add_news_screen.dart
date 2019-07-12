import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/resources/constants.dart';
import 'package:redux/redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
  String _summary;
  String _content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Title
                  Container(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Please type a title';
                        }
                      },
                      onSaved: (input) => _title = input,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hasFloatingPlaceholder: false,
                      ),
                      cursorColor: NewsColors.textBorderColorEnabled,
                      maxLines: null,
                    ),
                  ),

                  // Summary
                  Container(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Please type a summary';
                        }
                      },
                      onSaved: (input) => _summary = input,
                      decoration: InputDecoration(
                        labelText: 'Summary',
                        hasFloatingPlaceholder: false,
                      ),
                      cursorColor: NewsColors.textBorderColorEnabled,
                      maxLines: null,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Please type some content';
                        } else {
                          return '';
                        }
                      },
                      onSaved: (input) => _content = input,
                      decoration: InputDecoration(
                        labelText: 'Content',
                        alignLabelWithHint: true,
                        hasFloatingPlaceholder: false,
                      ),
                      cursorColor: NewsColors.textBorderColorEnabled,
                      maxLines: 3,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      var _image = await ImagePicker.pickImage(source: ImageSource.gallery);
                    },
                    child: Text('Image'),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      _formKey.currentState.save();
                      model.updateAddedNews(
                        _title,
                        _summary,
                        null,
                        _content
                      );
                      model.addNewsToFirebase();
                      Navigator.pop(context);
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
