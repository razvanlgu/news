import 'package:news/home/home_state.dart';

import 'package:meta/meta.dart';

@immutable
class AppState {
  final HomeState homeState;

  // Constructor
  AppState({
    this.homeState
  });

  factory AppState.initial() {
    return AppState(
      homeState: HomeState.initial()
    );
  }
}