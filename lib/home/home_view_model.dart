import 'package:meta/meta.dart';
import 'package:news/entities/news_item.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';

import 'home_actions.dart';

class HomeViewModel {
  final List<NewsItem> news;
  final double expandHeight;

  final Function() addNews;
  final Function(int index) toggleNews;
  // Constructor
  HomeViewModel({
    @required this.news,
    @required this.expandHeight,
    @required this.addNews,
    @required this.toggleNews,
  });

  factory HomeViewModel.fromStore(Store<AppState> store) {
    return HomeViewModel(
      news: store.state.homeState.news,
      expandHeight: store.state.homeState.expandHeight,
      addNews: () => store.dispatch(NavigateToAddNewsPage()),
      toggleNews: (int index) => store.dispatch(ToggleNewsAction(index)),
    );
  }
}