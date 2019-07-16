import 'package:meta/meta.dart';
import 'package:news/entities/news_item.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';

import 'home_actions.dart';

class HomeViewModel {
  final List<String> idNews;

  final Function() addNews;
  final Function(String id) toggleNews;
  final Function(String id) openNews;
  final Function() refresh;
  final Function(String id) makeFav;
  final Function(String id, bool isLike) like;

  // Constructor
  HomeViewModel({
    @required this.idNews,
    @required this.addNews,
    @required this.toggleNews,
    @required this.openNews,
    @required this.refresh,
    @required this.makeFav,
    @required this.like,
  });

  factory HomeViewModel.fromStore(Store<AppState> store) {
    return HomeViewModel(
      idNews: store.state.homeState.idNews,
      addNews: () => store.dispatch(NavigateToAddNewsPage()),
      toggleNews: (String id) => store.dispatch(ToggleNewsAction(id)),
      openNews: (String id) => store.dispatch(GetNewsPageAction(id)),
      refresh: () => store.dispatch(GetNewsAction()),
      makeFav: (String id) => store.dispatch(MakeFav(id)),
      like: (String id, bool isLike) => store.dispatch(Like(id, isLike)),
    );
  }
}