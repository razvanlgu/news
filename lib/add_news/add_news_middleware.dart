import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news/add_news/add_news_actions.dart';
import 'package:news/auth/auth_actions.dart';
import 'package:news/home/home_actions.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> addNewsMiddleware() => [
  TypedMiddleware<AppState, AddNewsToFirebaseAction>(_addNewsToFirebaseAction),
];

// Get all the news from database and put them in a List
void _addNewsToFirebaseAction(Store<AppState> store, AddNewsToFirebaseAction action, NextDispatcher next) async {
  // Add the news Document
   DocumentReference ref = await Firestore.instance.collection('news').add({
    'title' : store.state.addNewsState.title,
    'summary' : store.state.addNewsState.summary,
    'imageUrl' : store.state.addNewsState.imageUrl,
    'likes' : 0,
    'dislikes' : 0,
  });
   // Add the content Collection with the content and comment Collection
   ref.collection('content').add({'content' : store.state.addNewsState.content});
   ref.collection('comments');
  store.dispatch(GetNewsAction());
  next(action);
}