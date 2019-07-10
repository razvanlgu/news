
import 'package:meta/meta.dart';

@immutable
class AuthState {
  final String email;
  final String password;

  AuthState({this.password,this.email,});

  factory AuthState.initial()=>
      AuthState(
        email: '',
        password: '',
      );

  AuthState copyWith({String email, String password,String signInErrorMessage})=>
      AuthState(
        email: email ?? this.email,
        password: password ?? this.password
      );

}

