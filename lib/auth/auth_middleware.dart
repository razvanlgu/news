
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';
import 'auth_actions.dart';



List<Middleware<AppState>> authMiddleware() => [
  TypedMiddleware<AppState, GetFirebaseUserAction>(_getFirebaseUserAction),
  TypedMiddleware<AppState, RegisterFirebaseUserAction>(_registerFirebaseUserAction),
];

// Initialize the user in the userState onFirstInit
void _getFirebaseUserAction(Store<AppState> store, GetFirebaseUserAction action, NextDispatcher next) async {
      FirebaseUser firebaseUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: store.state.authState.email,
      password: store.state.authState.password);
  if (firebaseUser != null)
    store.dispatch(UpdateFirebaseUserAction(firebaseUser: firebaseUser));
  next(action);
}
void _registerFirebaseUserAction(Store<AppState> store, RegisterFirebaseUserAction action, NextDispatcher next) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: store.state.authState.email,
      password: store.state.authState.password
  );
    next(action);
}








