
import 'package:news/user_profile/user_details.dart';

class GetProfileAction{

}

class GetProfileSuccessAction{
  final UserDetails user;

  GetProfileSuccessAction(this.user);
}

class SaveProfileAction {

  final UserDetails userDetails;

  SaveProfileAction({this.userDetails});
}
class NavigateToLoginFirebaseUserAction {
}
class NavigateToHomePage {
}

