

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {

  final String name;
  final String email;
  final String phoneNumber;
  final int noNewsAdded;
  final bool isAdmin;


  UserDetails(
      {this.isAdmin, this.email, this.name, this.noNewsAdded, this.phoneNumber
      });

  factory UserDetails.fromJson(Map<String, dynamic> json){
    return UserDetails(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      noNewsAdded: json['noNewsAdded'],
    );
  }

  factory UserDetails.fromFirebase(DocumentSnapshot snap) {
    return UserDetails(
      name: snap['name'],
      email: snap['email'],
      phoneNumber: snap['phoneNumber'],
      noNewsAdded: snap['noNewsAdded'],
      isAdmin: snap['isAdmin'] ?? false,

    );
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = this.name;
    map['phoneNumber'] = this.phoneNumber;
    return map;
  }

  factory UserDetails.initial() {
    return UserDetails(
      name: '',
      email: '',
      phoneNumber: '',
      noNewsAdded: 0,
      isAdmin: false,
    );
  }


}