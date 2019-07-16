import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/resources/constants.dart';
import 'package:news/ui/users_actions.dart';
import 'package:news/user_profile/user_details.dart';
import 'package:redux/redux.dart';

import 'users_view_model.dart';
//import 'package:news/user_profile/user_profile_actions.dart';

class UsersPageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: StoreConnector<AppState, UsersPageViewModel>(
        converter: (store) => UsersPageViewModel.fromStore(store),
        builder: (context, userPageViewModel) =>
            _content(context, _screenHeight, userPageViewModel),
        onInit: _onInit,

      ),
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: NewsColors.textBorderColorEnabled,
//        onPressed: () {
//          Navigator.pushNamed(context, '/editProfile');
//        },
//        child: Icon(Icons.edit),
//        foregroundColor: Colors.white,
//      ),
    );
  }

  _onInit(Store<AppState> store) {
    store.dispatch(GetUsersAction());
  }
  Widget _content(BuildContext context, double _screenHeight, UsersPageViewModel usersPageViewModel) =>
       Container(
              constraints: BoxConstraints(
                minHeight: _screenHeight
                    - MediaQuery.of(context).padding.top
                    - AppBar().preferredSize.height,
              ),
              child: Column(
                children: <Widget>[
                  UsersList(_screenHeight, usersPageViewModel),
                 // DeleteButton(_screenHeight, _screenHeight, usersPageViewModel),
                ],
              ),

      );
}



class UsersList extends StatelessWidget {
  final double _screenHeight;
  final UsersPageViewModel model;
  UsersList(this._screenHeight, this.model);

  Widget tile(UserDetails user) {

    return Container(
      child: Column(
        children: <Widget>[
          Text('Name: ' + '${user.name}'),
          Text('Email: ' + '${user.email}'),
          Text('Phone Number: ' + '${user.name}'),
          Divider(),
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: model.listUserDetails
          .map((UserDetails user) {
            return tile(user);
        }).toList(),
      )
    );
  }
}
