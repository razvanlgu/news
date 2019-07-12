import 'package:news/auth/auth_state.dart';
import 'package:news/auth/user_state.dart';
import 'package:news/home/home_state.dart';
import 'package:meta/meta.dart';
import 'package:news/user_profile/user_profile_state.dart';

@immutable
class AppState {
  final HomeState homeState;
  final AuthState authState;
  final UserState userState;
  final UserProfileState userProfileState;

  AppState({
    this.homeState,
    this.authState,
    this.userState,
    this.userProfileState,
  });

  factory AppState.initial() {
    return AppState(
      homeState: HomeState.initial(),
      authState: AuthState.initial(),
      userState: UserState.initial(),
      userProfileState: UserProfileState.initial(),
    );
  }
}