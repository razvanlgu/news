import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';

class HomeViewModel {
  final String mesaj;

  // Constructor
  HomeViewModel({
    this.mesaj,
  });

  factory HomeViewModel.fromStore(Store<AppState> store) {
    return HomeViewModel(
      mesaj: store.state.homeState.mesaj,
    );
  }
}