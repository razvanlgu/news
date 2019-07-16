

import 'package:flutter/material.dart';
import 'package:news/redux/actions.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/user_profile/user_details.dart';
import 'package:news/user_profile/user_profile_actions.dart';
import 'package:redux/redux.dart';

class UserProfileViewModel{
  final UserDetails userDetails;
  final VoidCallback updateProfile;
  final VoidCallback goEditProfile;


  final Function(UserDetails) saveProfile;

  UserProfileViewModel( {this.userDetails, this.updateProfile, this.goEditProfile, this.saveProfile});

  factory UserProfileViewModel.fromStore(Store<AppState> store) =>
      UserProfileViewModel(
        userDetails: store.state.userProfileState.userDetails,
        updateProfile: () => store.dispatch(GetProfileAction()),
        goEditProfile: () => store.dispatch(NavigateToProfileEditAction()),
        saveProfile: (userDetails) => store.dispatch(SaveProfileAction(userDetails: userDetails)),
      );
}