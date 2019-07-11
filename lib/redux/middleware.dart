import 'package:news/auth/auth_actions.dart';
import 'package:news/auth/auth_middleware.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/resources/constants.dart';
import 'package:news/resources/keys.dart';
import 'package:redux/redux.dart';


List<Middleware<AppState>> middlewares() => [
  NavigationMiddleware(),
]
  ..addAll(authMiddleware());

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

    next(action);
  }
}