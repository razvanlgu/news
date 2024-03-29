import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';
import 'auth_actions.dart';

class AuthViewModel {
  final String email;
  final String userEmail;
  final String password;
  final FirebaseUser firebaseUser;

  final Function(String email, String password) updateEmailPassword;
  final Function() getFirebaseUser;
  final Function() registerFirebaseUser;
  final Function() logOut;

  AuthViewModel({this.logOut,this.password, this.email, this.firebaseUser,
    this.updateEmailPassword, this.getFirebaseUser, this.registerFirebaseUser, this.userEmail});

  factory AuthViewModel.fromStore(Store<AppState> store) {
    return AuthViewModel(
        email: store.state.authState.email,
        userEmail: store.state.userProfileState.userDetails.email,
        password: store.state.authState.password,
        firebaseUser: store.state.userState.firebaseUser,

        logOut: () =>
          store.dispatch(LogOutFirebaseUserAction()),

        updateEmailPassword: (String email,String password) =>
          store.dispatch(UpdateEmailPasswordAction(email:email, password:password)),

         getFirebaseUser: () =>
           store.dispatch(GetFirebaseUserAction()),

         registerFirebaseUser: () =>
          store.dispatch(RegisterFirebaseUserAction(),

    )
    );
  }
}
