import 'package:news/entities/news_item.dart';
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
  List<NewsItem> toggledList = state.news.map((NewsItem item) {
    if (item.id == action.id) {
      if (item.expandHeight == 0.0) {
        return item.copyWith(expandHeight: 200.0);
      } else {
        return item.copyWith(expandHeight: 0.0);
      }
    }
    return item.copyWith();
  }).toList();
  return state.copyWith(news: toggledList);
}