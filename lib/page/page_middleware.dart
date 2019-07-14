import 'package:news/home/home_actions.dart';
import 'package:news/page/page_actions.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


List<Middleware<AppState>> pageMiddleware() => [
  TypedMiddleware<AppState, GetNewsPageAction>(_getNewsPageAction),
];

// Get all the news from database and put them in a List
void _getNewsPageAction(Store<AppState> store, GetNewsPageAction action, NextDispatcher next) async {
  DocumentReference ref = await Firestore.instance.collection('news').document(action.id);
  DocumentSnapshot snapshot = await ref.get();
  DocumentSnapshot contentSnapshot = await ref.collection('content').document('content').get();
  final String title = snapshot['title'];
  final String imageUrl = snapshot['imageUrl'];
  final String content = contentSnapshot['content'];
  final int likes = snapshot['likes'];
  final int dislikes = snapshot['dislikes'];

  store.dispatch(UpdateNewsPageAction(
    title: title,
    imageUrl: imageUrl,
    content: content,
    likes: likes,
    dislikes: dislikes,
  ));
  store.dispatch(NavigateToNewsPage());
  next(action);
}