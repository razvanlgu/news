import 'package:news/home/home_view_model.dart';
import 'package:news/redux/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/ui/news_drawer.dart';
import 'package:redux/redux.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
//    _screenWidth = MediaQuery.of(context).size.width;
//    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer:NewsDrawer(),
      body: StoreConnector<AppState, HomeViewModel>(
        converter: (store) => HomeViewModel.fromStore(store),
        builder: (context, homeViewModel) => _content(context, homeViewModel),
        //onInit: _onInit,
      ),
    );
  }

/**
 * Get all the news
 */
  _onInit(Store<AppState> store) {

  }
  Widget _content(BuildContext context, HomeViewModel homeViewModel) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Text(homeViewModel.mesaj),
        ),
      ],
    );
  }
}