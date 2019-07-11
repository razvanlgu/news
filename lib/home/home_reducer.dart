import 'package:redux/redux.dart';

import 'home_actions.dart';
import 'home_state.dart';

final homeReducer = combineReducers<HomeState>([
  TypedReducer<HomeState, UpdateNewsAction >(_updateNewsAction),
]);

HomeState _updateNewsAction(HomeState state, UpdateNewsAction action) =>
    state.copyWith(news: action.news);