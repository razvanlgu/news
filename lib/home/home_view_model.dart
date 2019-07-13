import 'package:meta/meta.dart';
import 'package:news/entities/news_item.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';

import 'home_actions.dart';

class HomeViewModel {
  final List<NewsItem> news;

  final Function() addNews;
  final Function(String id) toggleNews;
  // Constructor
  HomeViewModel({
    @required this.news,
    @required this.addNews,
    @required this.toggleNews,
  });

  factory HomeViewModel.fromStore(Store<AppState> store) {
    return HomeViewModel(
      news: store.state.homeState.news,
      addNews: () => store.dispatch(NavigateToAddNewsPage()),
      toggleNews: (String id) => store.dispatch(ToggleNewsAction(id)),
    );
  }
}