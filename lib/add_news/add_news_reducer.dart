import 'package:redux/redux.dart';

import 'add_news_actions.dart';
import 'add_news_state.dart';


final addNewsReducer = combineReducers<AddNewsState>([
  TypedReducer<AddNewsState, UpdateAddedNewsAction>(_updateAddedNewsAction),
]);

AddNewsState _updateAddedNewsAction(AddNewsState state, UpdateAddedNewsAction action) =>
    state.copyWith(
      id: action.id,
      title: action.title,
      summary: action.title,
      imageUrl: action.imageUrl,
      content: action.content
    );