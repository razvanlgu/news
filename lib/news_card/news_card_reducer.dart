import 'package:news/news_card/news_card_actions.dart';
import 'package:news/news_card/news_card_state.dart';
import 'package:redux/redux.dart';

final newsCardReducer = combineReducers<NewsCardState>([
  TypedReducer<NewsCardState, UpdateCardInfoAction>(_updateCardInfoAction),
]);

NewsCardState _updateCardInfoAction(NewsCardState state, UpdateCardInfoAction action) =>
    state.copyWith(
      id: action.id,
      title: action.title,
      summary: action.summary,
      imageUrl: action.imageUrl,
      likes: action.likes,
      dislikes: action.dislikes,
      expandHeight: action.expandHeight,
      isFav: action.isFav,
      isLiked: action.isLiked,
    );