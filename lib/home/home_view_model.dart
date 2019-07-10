import 'package:meta/meta.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';

import 'home_state.dart';

class HomeViewModel {
  final String mesaj;
  final List<Item> news;

  // Constructor
  HomeViewModel({
    @required this.news,
    @required this.mesaj,
  });

  factory HomeViewModel.fromStore(Store<AppState> store) {
    return HomeViewModel(
      news: store.state.homeState.news,
      mesaj: store.state.homeState.mesaj,
    );
  }
}