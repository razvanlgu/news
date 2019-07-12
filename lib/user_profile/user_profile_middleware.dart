import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/user_profile/user_details.dart';
import 'package:news/user_profile/user_profile_actions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> profileMiddleware () =>[
  TypedMiddleware<AppState, GetProfileAction>(_getProfile),
  TypedMiddleware<AppState, SaveProfileAction>(_saveProfile),
  
];
void _getProfile(Store<AppState> store, GetProfileAction action, NextDispatcher next) async {
  FirebaseUser auth = await FirebaseAuth.instance.currentUser();

  DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(auth.uid).get();

  UserDetails user = UserDetails.fromFirebase(snapshot);

  store.dispatch(GetProfileSuccessAction(user));

  
}

void _saveProfile(Store<AppState> store, SaveProfileAction action, NextDispatcher next) async{
  FirebaseUser auth = await FirebaseAuth.instance.currentUser();
  
  await Firestore.instance.collection('users').document(auth.uid).updateData(action.userDetails.toMap());
  
  store.dispatch(NavigateToHomeScreenActionAction());
  next(action);
}