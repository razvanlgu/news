

import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
class UserState {
  final FirebaseUser firebaseUser;

  UserState({this.firebaseUser
   });

  factory UserState.initial() {
    return UserState(
      firebaseUser: null,

    );
  }


  UserState copyWith({FirebaseUser firebaseUser}) =>
      UserState(
          firebaseUser: firebaseUser ?? this.firebaseUser
      );

}