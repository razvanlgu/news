import 'package:meta/meta.dart';
import 'package:news/entities/news_item.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';

class HomeViewModel {
  final List<NewsItem> news;

  // Constructor
  HomeViewModel({
    @required this.news,
  });

  factory HomeViewModel.fromStore(Store<AppState> store) {
    return HomeViewModel(
      news: store.state.homeState.news,
    );
  }
}