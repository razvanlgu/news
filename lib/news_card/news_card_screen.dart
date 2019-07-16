import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/resources/constants.dart';
import 'package:news/resources/news_icons_icons.dart';
import 'package:redux/redux.dart';

import 'news_card_actions.dart';
import 'news_card_view_model.dart';

class NewsCardScreen extends StatelessWidget {
  final String newsId;

  NewsCardScreen(this.newsId);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, NewsCardViewModel>(
      converter: (store) => NewsCardViewModel.fromStore(store),
      builder: (context, newsCardViewModel) => _content(context, newsCardViewModel),
      onInit: _onInit,
    );
  }

  _onInit(Store<AppState> store) {
    store.dispatch(GetCardInfoAction(newsId));
  }

  Widget _content(BuildContext context, NewsCardViewModel newsCardViewModel) {
    final double _screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsetsDirectional.only(top: 15.0),
      child: RaisedButton(
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.all(0.0),
        elevation: 10,
        color: Colors.white,
//child: Text('WORK!!'),
        child: Column(
          children: <Widget>[
            Container(
              height: 0.21 * _screenHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: FractionalOffset.topCenter,
                  image: NetworkImage(newsCardViewModel.imageUrl),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: Text(
                newsCardViewModel.title,
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 600),
              constraints: BoxConstraints(
                maxHeight: newsCardViewModel.expandHeight,
              ),
              padding: EdgeInsetsDirectional.only(start: 15.0, end: 15.0, bottom: 10),
              child: Text(
                newsCardViewModel.summary,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 600),
              constraints: BoxConstraints(
                maxHeight: newsCardViewModel.expandHeight,
              ),
              padding: EdgeInsetsDirectional.only(start: 15.0, end: 15.0, bottom: 10),
              child: FlatButton(
                onPressed: () =>
//                    newsCardViewModel.openNews(newsId),
                print('VIEW MOREEEE!!!'),
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
                    '${newsCardViewModel.likes}',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  IconButton(
                    color: Colors.black,
                    icon: newsCardViewModel.isLiked == true  ? Icon(NewsIcons.like_fill,color: Colors.blue) :
                    Icon(NewsIcons.like, color:Colors.black),
                    onPressed: () =>
//                        model.like(newsId, true),
                  print('LIKE!!!'),
                  ),
                  Text(
                    '${newsCardViewModel.dislikes}',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  IconButton(
                    color: Colors.black,
                    icon: newsCardViewModel.isLiked == false  ? Icon(NewsIcons.dislike_fill,color: Colors.redAccent) :
                    Icon(NewsIcons.dislike, color:Colors.black),
                    onPressed: () =>
//                        model.like(newsId, false),
                  print('DISLIKE!!!!'),
                  ),
                  Expanded(child: Container(),),
                  IconButton(
                    //color: Colors.black,
                    icon: newsCardViewModel.isFav == true  ? Icon(Icons.favorite,color: Colors.red) :
                    Icon(Icons.favorite_border, color:Colors.black),
                    onPressed: () =>
//                        model.makeFav(item.id),
                  print('ADD TO FAVV'),
                  ),
                ],
              ),
            ),
          ],
        ),
        onPressed: () =>
//            model.toggleNews(item.id),
          print('TOGLE!!'),
      ),
    );
  }
}