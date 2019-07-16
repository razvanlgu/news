import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/ui/users_actions.dart';
import 'package:news/user_profile/user_details.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> usersMiddleware() => [
  TypedMiddleware<AppState, GetUsersAction>(_getUsersAction),
];

void _getUsersAction(Store<AppState> store, GetUsersAction action, NextDispatcher next)  async{
  QuerySnapshot snapshots = await Firestore.instance.collection('users').getDocuments();
  List<UserDetails> listUserDetails = snapshots.documents
    .map((DocumentSnapshot document) => UserDetails(
      name: document.data['name'],
      email: document.data['email'],
      phoneNumber: document.data['phoneNumber'],
      noNewsAdded: document.data['noNewsAdded'],
      isAdmin: document.data['isAdmin'] ?? false,
  )).toList();
  if (listUserDetails != null) {
    store.dispatch(UpdateUsersAction(listUserDetails: listUserDetails));
  }
  next(action);
}