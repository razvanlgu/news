import 'package:news/auth/auth_reducer.dart';
import 'package:news/home/home_reducer.dart';
import 'package:news/redux/appstate.dart';


AppState appReducer(AppState state, dynamic action) =>
    AppState(
      userState: userReducer(state.userState , action),
      authState: authReducer(state.authState, action),
      homeState: homeReducer(state.homeState, action),
    );
