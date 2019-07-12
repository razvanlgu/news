
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';
import 'auth_actions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



List<Middleware<AppState>> authMiddleware() => [
  TypedMiddleware<AppState, GetFirebaseUserAction>(_getFirebaseUserAction),
  TypedMiddleware<AppState, RegisterFirebaseUserAction>(_registerFirebaseUserAction),
  TypedMiddleware<AppState, LogOutFirebaseUserAction>(_logOutFirebaseUser),
];

// Initialize the user in the userState onFirstInit
void _getFirebaseUserAction(Store<AppState> store, GetFirebaseUserAction action, NextDispatcher next) async {
      FirebaseUser firebaseUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: store.state.authState.email,
      password: store.state.authState.password);
  if (firebaseUser != null)
     store.dispatch(UpdateFirebaseUserAction(firebaseUser: firebaseUser));
     store.dispatch(NavigateToHomePage());
  next(action);
}
void _registerFirebaseUserAction(Store<AppState> store, RegisterFirebaseUserAction action, NextDispatcher next) async {
    FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: store.state.authState.email,
      password: store.state.authState.password
  );

    Firestore.instance.collection('users').document(user.uid).setData({ 'email': '${ store.state.authState.email}' });
    next(action);
}

void _logOutFirebaseUser(Store<AppState> store, LogOutFirebaseUserAction action, NextDispatcher next) async {

  await FirebaseAuth.instance.signOut();
  store.dispatch(UpdateFirebaseUserAction(firebaseUser: null, authenticated: false));
  store.dispatch(NavigateToLoginFirebaseUserAction());

  // Delete the sharedPreferences data
  //store.dispatch(DeleteSharedPrefsAction());

  next(action);
}









