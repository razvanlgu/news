import 'package:meta/meta.dart';
import 'package:news/user_profile/user_details.dart';

@immutable
class UserProfileState {
  final UserDetails userDetails;

  UserProfileState({this.userDetails});

  factory UserProfileState.initial() =>
      UserProfileState(
          userDetails: UserDetails.initial(),

      );

  UserProfileState copyWith({UserDetails userDetails, String language}) =>
      UserProfileState(
          userDetails: userDetails ?? this.userDetails,
      );
}