import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_actions.dart';
import 'package:news/entities/news_item.dart';

List<Middleware<AppState>> homeMiddleware() => [
  TypedMiddleware<AppState, GetNewsAction>(_getNewsAction),
];

// Get all the news from database and put them in a List
void _getNewsAction(Store<AppState> store, GetNewsAction action, NextDispatcher next) async {

  QuerySnapshot snapshots = await Firestore.instance.collection('news').getDocuments();
  List<NewsItem> news = snapshots.documents
      .map((DocumentSnapshot document) => NewsItem(
        id: document.documentID,
        title: document.data['title'],
        summary: document.data['summary'],
        imageUrl: document.data['imageUrl'],
        likes: document.data['likes'],
        dislikes: document.data['dislikes']
      )).toList();
  if (news != null) {
    store.dispatch(UpdateNewsAction(news: news));
  }
  next(action);
}