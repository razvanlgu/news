import 'package:meta/meta.dart';
import 'package:news/user_profile/user_details.dart';

@immutable
class UsersPageState {

  final List<UserDetails> listUserDetails;

  UsersPageState({this.listUserDetails});

  factory UsersPageState.initial() =>
      UsersPageState(
        listUserDetails: List.unmodifiable(<UserDetails>[]),
      );

  UsersPageState copyWith({
    List<UserDetails> listUserDetails,
  }) =>
      UsersPageState(
        listUserDetails: listUserDetails ?? this.listUserDetails,
      );

}