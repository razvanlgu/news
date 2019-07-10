import 'package:news/home/home_view_model.dart';
import 'package:news/redux/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'home_state.dart';

class HomeScreen extends StatelessWidget {

  Widget _content(BuildContext context, HomeViewModel homeViewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _myAppBar(),
        _newsList(homeViewModel),
//        _filterSortButtons()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
//    _screenWidth = MediaQuery.of(context).size.width;
//    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // De adaugat drawer
      body: StoreConnector<AppState, HomeViewModel>(
        converter: (store) => HomeViewModel.fromStore(store),
        builder: (context, homeViewModel) => _content(context, homeViewModel),
        onInit: _onInit,
      ),
    );
  }

/**
 * Get all the news
 */
  _onInit(Store<AppState> store) {
    store.dispatch(GetNews())
  }
}

  // AppBar
  class _myAppBar extends StatelessWidget{

    @override
    Widget build(BuildContext context) {
      return AppBar(

      );
    }
  }

  // News list
  class _newsList extends StatelessWidget {

  final HomeViewModel model;

  _newsList(this.model);

  @override
    Widget build(BuildContext context) {
      return Expanded(
        child: ListView(
          children: model.news
              .map((Item item) => RaisedButton(
                child: Text(item.continut),
                onPressed: () => print(item.continut),
              )).toList(),
        ),
     );
    }
  }