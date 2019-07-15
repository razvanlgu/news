import 'package:meta/meta.dart';
import 'package:news/entities/news_item.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';

import 'home_actions.dart';

class HomeViewModel {
  final List<NewsItem> news;

  final Function() addNews;
  final Function(String id) toggleNews;
  final Function(String id) openNews;
  final Function(String id) makeFav;
  final Function(String id, bool isLike) like;

  // Constructor
  HomeViewModel({
    @required this.news,
    @required this.addNews,
    @required this.toggleNews,
    @required this.openNews,
    this.makeFav,
    this.like,
  });

  factory HomeViewModel.fromStore(Store<AppState> store) {
    return HomeViewModel(
      news: store.state.homeState.news,
      addNews: () => store.dispatch(NavigateToAddNewsPage()),
      toggleNews: (String id) => store.dispatch(ToggleNewsAction(id)),
      openNews: (String id) => store.dispatch(GetNewsPageAction(id)),
      makeFav: (String id) => store.dispatch(MakeFav(id)),
      like: (String id, bool isLike) => store.dispatch(Like(id, isLike)),
    );
  }
}