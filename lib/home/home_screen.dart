import 'package:news/entities/news_item.dart';
import 'package:news/home/home_view_model.dart';
import 'package:news/news_card/news_card_screen.dart';
import 'package:news/redux/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/resources/constants.dart';
import 'package:news/resources/keys.dart';
import 'package:news/resources/news_icons_icons.dart';
import 'package:news/ui/news_drawer.dart';
import 'package:redux/redux.dart';

import 'home_actions.dart';
import 'home_screen_favs.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
        converter: (store) => HomeViewModel.fromStore(store),
        builder: (context, homeViewModel) => _content(context, homeViewModel),
        onInit: _onInit,
      );
  }

  // Get all the news ids
  _onInit(Store<AppState> store) {
    store.dispatch(GetNewsAction());
  }

  Widget _content(BuildContext context, HomeViewModel homeViewModel) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: NewsDrawer(),
      appBar: AppBar(
        title:Text('News'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () => homeViewModel.refresh(),
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            tooltip: 'Favorite news',
            onPressed: () => Keys.navKey.currentState.pushNamed(Routes.favs),
          ),
          IconButton(
            icon: Icon(Icons.add_circle),
            tooltip: 'Add news',
            onPressed: () => homeViewModel.addNews(),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          NewsList(homeViewModel),
//          FilterSortButtons(_screenWidth, _screenHeight),
        ],
      ),
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
        children: model.idNews
            .map((String newsId) {
          return NewsCardScreen(newsId);
        }).toList(),
      ),
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return Expanded(
//      child: ListView.builder(
//        scrollDirection: Axis.vertical,
//          itemCount: model.idNews.length,
//          itemBuilder: (BuildContext context, int index) {
//            return NewsCardScreen(model.idNews[index]);
//          }
//      ),
//    );
//  }
}

class FilterSortButtons extends StatelessWidget {
  final double _screenWidth;
  final double _screenHeight;

  // Constructor
  FilterSortButtons(this._screenWidth, this._screenHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _screenWidth,
      child: Stack(
        overflow: Overflow.clip,
        children: <Widget>[
          Positioned(
            right: 0.0,
            left: _screenWidth / 2,
            child: Container(
//          duration: Duration(seconds: 1),
              height: 50,
              decoration: BoxDecoration(
                color: NewsColors.textFillColorFocused,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0)),
                boxShadow: [
                  BoxShadow(
                    color: NewsColors.textBorderColorFocused,
                    spreadRadius: 4.0,
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: NewsColors.textBorderColorFocused,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
//          duration: Duration(seconds: 1),
              width: _screenWidth / 2,
              height: 50,
              decoration: BoxDecoration(
                color: NewsColors.textFillColorFocused,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(topRight: Radius.circular(30.0)),
                boxShadow: [
                  BoxShadow(
                    color: NewsColors.textBorderColorFocused,
                    spreadRadius: 4.0,
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Sort',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: NewsColors.textBorderColorFocused,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}