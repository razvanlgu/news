import 'package:news/add_news/add_news_state.dart';
import 'package:news/auth/auth_state.dart';
import 'package:news/auth/user_state.dart';
import 'package:news/home/home_state.dart';
import 'package:meta/meta.dart';
import 'package:news/page/page_state.dart';
import 'package:news/ui/users_state.dart';
import 'package:news/user_profile/user_profile_state.dart';

@immutable
class AppState {
  final HomeState homeState;
  final AuthState authState;
  final UserState userState;
  final AddNewsState addNewsState;
  final UserProfileState userProfileState;
  final PageState pageState;
  final UsersPageState usersPageState;

  AppState({
    this.homeState,
    this.authState,
    this.userState,
    this.addNewsState,
    this.userProfileState,
    this.pageState,
    this.usersPageState,
  });

  factory AppState.initial() {
    return AppState(
      homeState: HomeState.initial(),
      authState: AuthState.initial(),
      userState: UserState.initial(),
      addNewsState: AddNewsState.initial(),
      userProfileState: UserProfileState.initial(),
      pageState: PageState.initial(),
      usersPageState: UsersPageState.initial(),
    );
  }
}