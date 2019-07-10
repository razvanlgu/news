import 'package:news/auth/auth_state.dart';
import 'package:news/auth/user_state.dart';
import 'package:redux/redux.dart';
import 'auth_actions.dart';


final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, UpdateEmailPasswordAction >(_updateEmailPassswordAction),
]);

AuthState _updateEmailPassswordAction(AuthState state, UpdateEmailPasswordAction action) =>
    state.copyWith(
      email: action.email,
      password: action.password,
    );


final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, UpdateFirebaseUserAction>(_updateFirebaseUserAction),
]);

UserState _updateFirebaseUserAction(UserState state, UpdateFirebaseUserAction action) =>
    state.copyWith(
  firebaseUser: action.firebaseUser,

    );

