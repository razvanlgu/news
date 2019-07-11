


import 'package:news/user_profile/user_profile_actions.dart';
import 'package:news/user_profile/user_profile_state.dart';
import 'package:redux/redux.dart';

final userProfileReducer = combineReducers<UserProfileState> ([
  TypedReducer<UserProfileState, GetProfileSuccessAction> (_getSuccess),
  TypedReducer<UserProfileState, SaveProfileAction> (_saveProfileSuccess),
]);

UserProfileState _getSuccess(UserProfileState state, GetProfileSuccessAction action) =>
    state.copyWith(userDetails: action.user);

UserProfileState _saveProfileSuccess(UserProfileState state, SaveProfileAction action) =>
    state.copyWith(userDetails: action.userDetails);