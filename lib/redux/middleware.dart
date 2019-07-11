import 'package:news/auth/auth_actions.dart';
import 'package:news/auth/auth_middleware.dart';
import 'package:news/home/home_middleware.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/resources/constants.dart';
import 'package:news/resources/keys.dart';
import 'package:news/user_profile/user_profile_middleware.dart';
import 'package:redux/redux.dart';

import 'actions.dart';


List<Middleware<AppState>> middlewares() => [
  NavigationMiddleware(),
]
  ..addAll(authMiddleware())
  ..addAll(homeMiddleware())
  ..addAll(profileMiddleware());

class NavigationMiddleware extends MiddlewareClass<AppState>{
  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is NavigateToLoginFirebaseUserAction) {
      Keys.navKey.currentState.pop();
      Keys.navKey.currentState.pushReplacementNamed(Routes.login);
    }
    if (action is NavigateToHomePage) {
      //Keys.navKey.currentState.pop();
      Keys.navKey.currentState.pushReplacementNamed(Routes.home);
    }
    if (action is NavigateToProfileScreenAction) {
      Keys.navKey.currentState.pushNamed(Routes.profile);
    }

    next(action);
  }
}