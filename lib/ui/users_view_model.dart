import 'package:flutter/material.dart';
import 'package:news/redux/actions.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/ui/users_actions.dart';
import 'package:news/user_profile/user_details.dart';
//import 'package:news/user_profile/user_profile_actions.dart';
import 'package:redux/redux.dart';


class UsersPageViewModel {
  final List<UserDetails> listUserDetails;

  final Function() getUsers;

  UsersPageViewModel({
    @required this.listUserDetails,
    this.getUsers,
  });

  factory UsersPageViewModel.fromStore(Store<AppState> store) =>
      UsersPageViewModel(
        listUserDetails: store.state.usersPageState.listUserDetails,
        //getUsers() => store.dispatch(GetUsersAction),
      );
}