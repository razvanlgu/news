import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_actions.dart';

List<Middleware<AppState>> homeMiddleware() => [
  TypedMiddleware<AppState, GetNewsAction>(_getNewsAction),
];

// Get all the news from database and put them in a List
void _getNewsAction(Store<AppState> store, GetNewsAction action, NextDispatcher next) async {

//  QuerySnapshot snapshots = await Firestore.instance.collection('news').getDocuments();
//  print('${snapshots.documents[0].data['title']}');

}