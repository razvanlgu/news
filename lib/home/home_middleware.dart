import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_actions.dart';
import 'package:news/entities/news_item.dart';

List<Middleware<AppState>> homeMiddleware() => [
  TypedMiddleware<AppState, GetNewsAction>(_getNewsAction),
  TypedMiddleware<AppState, MakeFav>(_makeFav),
  TypedMiddleware<AppState, Like>(_like),

];

// Get all the news from database and put them in a List
void _getNewsAction(Store<AppState> store, GetNewsAction action, NextDispatcher next) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(user.uid).get();

  QuerySnapshot snapshots = await Firestore.instance.collection('news').getDocuments();
  List<NewsItem> news = snapshots.documents
      .map((DocumentSnapshot document) => NewsItem(
        id: document.documentID,
        title: document.data['title'],
        summary: document.data['summary'],
        imageUrl: document.data['imageUrl'],
        likes: document.data['likes'],
        dislikes: document.data['dislikes'],
        expandHeight: 0.0,
        isFav: snapshot.data['favs']['${document.documentID}'] ?? false,
        isLiked: snapshot.data['likes']['${document.documentID}'] ,

  )).toList();

  if (news != null) {
    store.dispatch(UpdateNewsAction(news: news));
  }
  next(action);
}


void _like(Store<AppState> store, Like action, NextDispatcher next) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(user.uid).get();
  var  isLiked =  snapshot.data['likes']['${action.id}'];

  if(action.isLike == true ){
    if(isLiked == true) {
      await Firestore.instance.collection('users').document(user.uid).updateData({'likes.${action.id}': null});
      await Firestore.instance.collection('news').document(action.id).updateData({'likes' : FieldValue.increment(-1)});
    }
    else{
      await Firestore.instance.collection('users').document(user.uid).updateData({'likes.${action.id}': true});
      await Firestore.instance.collection('news').document(action.id).updateData({'likes' : FieldValue.increment(1)});
      if (isLiked == false){
        await Firestore.instance.collection('news').document(action.id).updateData({'dislikes' : FieldValue.increment(-1)});
      }
    }
  }
  else{
    if(isLiked == false) {
      await Firestore.instance.collection('users').document(user.uid).updateData({'likes.${action.id}': null});
      await Firestore.instance.collection('news').document(action.id).updateData({'dislikes' : FieldValue.increment(-1)});
    }
    else{
      await Firestore.instance.collection('users').document(user.uid).updateData({'likes.${action.id}': false});
      await Firestore.instance.collection('news').document(action.id).updateData({'dislikes' : FieldValue.increment(1)});
      if (isLiked == true) {
        await Firestore.instance.collection('news').document(action.id).updateData({'likes' : FieldValue.increment(-1)});
      }
    }
  }
  store.dispatch(GetNewsAction());

  next(action);

}

  void _makeFav(Store<AppState> store, MakeFav action, NextDispatcher next) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(user.uid).get();

  var  isFav =  snapshot.data['favs']['${action.id}'];
  if(isFav == true){
    await Firestore.instance.collection('users').document(user.uid).updateData({'favs.${action.id}': false});
  }
  else await  Firestore.instance.collection('users').document(user.uid).updateData({'favs.${action.id}': true});

  store.dispatch(GetNewsAction());

  next(action);




}


