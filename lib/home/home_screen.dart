import 'package:news/entities/news_item.dart';
import 'package:news/home/home_view_model.dart';
import 'package:news/redux/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/resources/constants.dart';
import 'package:news/resources/keys.dart';
import 'package:news/ui/news_drawer.dart';
import 'package:redux/redux.dart';

import 'home_actions.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    _screenWidth = MediaQuery.of(context).size.width;
//    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: NewsDrawer(),
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
    store.dispatch(GetNewsAction());
  }

  Widget _content(BuildContext context, HomeViewModel homeViewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        MyAppBar(homeViewModel),
        NewsList(homeViewModel),
        FilterSortButtons(),
      ],
    );
  }
}

// AppBar
class MyAppBar extends StatelessWidget {
  final HomeViewModel model;
  MyAppBar(this.model);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add_circle),
          tooltip: 'Add news',
          onPressed: () => model.addNews(),
        ),
      ],
    );
  }
}

// News list
class NewsList extends StatelessWidget {
  final HomeViewModel model;
  NewsList(this.model);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        children: model.news
            .map((NewsItem item) => Container(
                  margin: EdgeInsetsDirectional.only(top: 15.0),
                  child: RaisedButton(
                    padding: EdgeInsets.all(0.0),
                    elevation: 10,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Image.network(item.imageUrl),
                        Text(item.title),
                      ],
                    ),
                    onPressed: () => print(item.title),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class FilterSortButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(onPressed: () => print('SORT!!!!'), child: Text('Sort')),
          FlatButton(
              onPressed: () => print('FILTER!!!!'), child: Text('Filter')),
        ],
      ),
    );
  }
}
