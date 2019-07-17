import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:news/add_news/add_news_actions.dart';
import 'package:news/home/home_actions.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> addNewsMiddleware() => [
  TypedMiddleware<AppState, AddNewsToFirebaseAction>(_addNewsToFirebaseAction),
  TypedMiddleware<AppState, UploadPhoto>(_uploadPhoto),
];

// Get all the news from database and put them in a List
void _addNewsToFirebaseAction(Store<AppState> store, AddNewsToFirebaseAction action, NextDispatcher next) async {
  // Add the news Document
  DocumentReference ref = await Firestore.instance.collection('news').document();
  ref.setData({
    'id' : ref.documentID,
    'title' : store.state.addNewsState.title,
    'summary' : store.state.addNewsState.summary,
    'imageUrl' :  action.imageUrl ?? store.state.addNewsState.imageUrl,
    'likes' : 0,
    'dislikes' : 0,
  });
  // Add the id of the news
   // Add the content Collection with the content and comment Collection
   ref.collection('content').document('content').setData({'content' : store.state.addNewsState.content});
   ref.collection('comments');
  store.dispatch(GetNewsAction());
  next(action);
}

void _uploadPhoto(Store<AppState> store, UploadPhoto action, NextDispatcher next) async {
  FirebaseStorage _storage = FirebaseStorage.instance;
  StorageReference reference = _storage.ref().child('News/' + store.state.addNewsState.title + '.jpg');
  
  //Upload the file to firebase
  StorageUploadTask uploadTask = reference.putFile(action.img);
  StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  String location = await taskSnapshot.ref.getDownloadURL();
  store.dispatch(AddNewsToFirebaseAction(imageUrl: location));
  next(action);

}