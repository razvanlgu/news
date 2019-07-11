import 'package:news/auth/auth_middleware.dart';
import 'package:news/home/home_middleware.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';


List<Middleware<AppState>> middlewares() => [
]
  ..addAll(authMiddleware())
  ..addAll(homeMiddleware());

class NavigationMiddleware extends MiddlewareClass<AppState>{
  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
  }
}