import 'package:news/page/page_actions.dart';
import 'package:news/page/page_state.dart';
import 'package:redux/redux.dart';


final pageReducer = combineReducers<PageState>([
  TypedReducer<PageState, UpdateNewsPageAction >(_updateNewsPageAction),
]);

PageState _updateNewsPageAction(PageState state, UpdateNewsPageAction action) =>
    state.copyWith(
      title: action.title,
      imageUrl: action.imageUrl,
      content: action.content,
      likes: action.likes,
      dislikes: action.dislikes,
    );