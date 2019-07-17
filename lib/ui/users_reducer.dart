

import 'package:news/ui/users_actions.dart';
import 'package:news/ui/users_state.dart';
import 'package:redux/redux.dart';

final usersReducer = combineReducers<UsersPageState>([
  TypedReducer<UsersPageState, UpdateUsersAction >(_updateUsersAction),
]);

UsersPageState _updateUsersAction(UsersPageState state, UpdateUsersAction action) =>
    state.copyWith(
        listUserDetails: action.listUserDetails
    );