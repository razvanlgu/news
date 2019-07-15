import 'package:news/entities/news_item.dart';
import 'package:news/home/home_view_model.dart';
import 'package:news/redux/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/resources/constants.dart';
import 'package:news/resources/keys.dart';
import 'package:news/resources/news_icons_icons.dart';
import 'package:news/ui/news_drawer.dart';
import 'package:redux/redux.dart';

import 'home_actions.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      drawer: NewsDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () => homeViewModel.refresh(),
          ),
          IconButton(
            icon: Icon(Icons.add_circle),
            tooltip: 'Add news',
            onPressed: () => homeViewModel.addNews(),
          ),
        ],
      ),
      body: Stack(
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          NewsList(_screenHeight, homeViewModel),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: FilterSortButtons(_screenWidth, _screenHeight),
          ),
        ],
      ),
    );
  }
}

// News list
class NewsList extends StatelessWidget {
  final double _screenHeight;
  final HomeViewModel model;
  NewsList(this._screenHeight, this.model);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
      children: model.news
          .map((NewsItem item) {
        return Container(
          margin: EdgeInsetsDirectional.only(top: 15.0),
          child: RaisedButton(
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.all(0.0),
            elevation: 10,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  height: 0.21 * _screenHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.topCenter,
                      image: NetworkImage(item.imageUrl),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  constraints: BoxConstraints(
                    maxHeight: item.expandHeight,
                  ),
                  padding: EdgeInsetsDirectional.only(start: 15.0, end: 15.0, bottom: 10),
                  child: Text(
                    item.summary,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  constraints: BoxConstraints(
                    maxHeight: item.expandHeight,
                  ),
                  padding: EdgeInsetsDirectional.only(start: 15.0, end: 15.0, bottom: 10),
                  child: FlatButton(
                    onPressed: () => model.openNews(item.id),
                    color: NewsColors.textBorderColorFocused,
                    child: Text('View More'),
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.only(start: 15.0, end: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${item.likes}',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      IconButton(
                        color: Colors.black,
                        icon: Icon(NewsIcons.like),
                        onPressed: () => print('LIKE!!!'),
                      ),
                      Text(
                        '${item.likes}',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      IconButton(
                        icon: Icon(NewsIcons.dislike),
                        onPressed: () => print('DISLIKE!!!'),
                      ),
                      Expanded(child: Container(),),
                      IconButton(
                        color: Colors.black,
                        icon: Icon(Icons.favorite_border),
                        onPressed: () => print('ADD TO FAVORITE!!!'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            onPressed: () => model.toggleNews(item.id),
          ),
        );
      }).toList(),
    );
  }
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

