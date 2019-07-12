import 'package:news/add_news/add_news_state.dart';
import 'package:news/auth/auth_state.dart';
import 'package:news/auth/user_state.dart';
import 'package:news/home/home_state.dart';

import 'package:meta/meta.dart';

@immutable
class AppState {
  final HomeState homeState;
  final AuthState authState;
  final UserState userState;
  final AddNewsState addNewsState;

  // Constructor
  AppState({
    this.homeState,
    this.authState,
    this.userState,
    this.addNewsState
  });

  factory AppState.initial() {
    return AppState(
      homeState: HomeState.initial(),
      authState: AuthState.initial(),
      userState: UserState.initial(),
      addNewsState: AddNewsState.initial()
    );
  }
}