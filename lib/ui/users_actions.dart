import 'package:news/user_profile/user_details.dart';

class GetUsersAction{}

class UpdateUsersAction {
  final List<UserDetails> listUserDetails;

  UpdateUsersAction({this.listUserDetails});
}