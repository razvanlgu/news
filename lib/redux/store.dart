import 'dart:async';

import 'package:news/redux/appstate.dart';
import 'package:news/redux/reducer.dart';
import 'package:news/redux/middleware.dart';
import 'package:redux/redux.dart';

Future<Store<AppState>> createStore() async {
  return Store(
    appReducer,
    initialState: AppState.initial(),
//    middleware: middlewares;
  );
}