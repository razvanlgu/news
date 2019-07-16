import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';

import 'news_card_actions.dart';

List<Middleware<AppState>> newsCardMiddleware() => [
  TypedMiddleware<AppState, GetCardInfoAction>(_getCardInfoAction),
];

// Get all the info about a news by id
void _getCardInfoAction(Store<AppState> store, GetCardInfoAction action, NextDispatcher next) async {
  DocumentSnapshot snapshot = await Firestore.instance.collection('news').document(action.newsId).get();

  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  DocumentSnapshot snapshotUser = await Firestore.instance.collection('users').document(user.uid).get();

  store.dispatch(UpdateCardInfoAction(
    id: action.newsId,
    title: snapshot.data['title'],
    summary: snapshot['summary'],
    imageUrl: snapshot['imageUrl'],
    likes: snapshot['likes'],
    dislikes: snapshot['dislikes'],
    expandHeight: snapshot['expandHeight'],
    isFav: snapshotUser.data['favs'][action.newsId] ?? false,
    isLiked: snapshotUser.data['likes'][action.newsId],
  ));
  
  next(action);
}