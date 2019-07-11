import 'package:firebase_auth/firebase_auth.dart';


class GetFirebaseUserAction {}

class UpdateEmailPasswordAction{
  final String email;
  final String password;

  UpdateEmailPasswordAction({this.email,this.password});
}

class UpdateFirebaseUserAction {
  final FirebaseUser firebaseUser;
  final bool authenticated;


  UpdateFirebaseUserAction({this.firebaseUser, this.authenticated = true,
    });
}

class RegisterFirebaseUserAction{
}

class LogOutFirebaseUserAction {
}

class NavigateToLoginFirebaseUserAction {
}
class NavigateToHomePage {
}




