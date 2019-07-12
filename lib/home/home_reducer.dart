import 'package:redux/redux.dart';

import 'home_actions.dart';
import 'home_state.dart';

final homeReducer = combineReducers<HomeState>([
  TypedReducer<HomeState, UpdateNewsAction >(_updateNewsAction),
  TypedReducer<HomeState, ToggleNewsAction >(_toggleNewsAction),
]);

HomeState _updateNewsAction(HomeState state, UpdateNewsAction action) =>
    state.copyWith(news: action.news);

HomeState _toggleNewsAction(HomeState state, ToggleNewsAction action) {
  if (state.expandHeight == 0.0) {
    return state.copyWith(expandHeight: 200.0);
  } else {
    return state.copyWith(expandHeight: 0.0);
  }
}