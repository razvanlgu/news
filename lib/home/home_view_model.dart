
class HomeViewModel {
  final String mesaj;

  // Constructor
  HomeViewModel({
    this.mesaj;
  });

  factory HomeViewModel.fromStore(Store<AppState> store) {
    return HomeViewModel(
      mesaj: store.state.mesaj,
    );
  }
}