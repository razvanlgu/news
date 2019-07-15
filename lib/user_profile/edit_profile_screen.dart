import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/resources/constants.dart';
import 'package:news/user_profile/user_details.dart';
import 'package:news/user_profile/user_profile_view_model.dart';

class EditUserProfileScreen extends StatefulWidget {
  @override
  _EditUserProfileScreenState createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  final _formProfileKey = GlobalKey<FormState>();
  Map<String, dynamic> userDetailsMap = Map();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: StoreConnector<AppState, UserProfileViewModel>(
          converter: (store) => UserProfileViewModel.fromStore(store),
          builder: (context, userProfileViewModel) =>
              _content(context, userProfileViewModel),
        ));
  }


  Widget _content(BuildContext context, UserProfileViewModel userProfileViewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _formProfileKey.currentState.save();
                userProfileViewModel
                    .saveProfile(UserDetails.fromJson(userDetailsMap));
              },
            ),
          ),
        ],
      ),
      body: Center(
        child:Form(
          key: _formProfileKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Name:',
                          hasFloatingPlaceholder: false
                      ),
                      textInputAction: TextInputAction.done,
                      initialValue:
                      userProfileViewModel.userDetails.name,
                      onSaved: (val) {
                        userDetailsMap['name'] = val;
                      },
                    ),
                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(bottom:20,top: 20),
//                    child: TextFormField(
//                      decoration: InputDecoration(
//                          labelText: 'Email:',
//                          hasFloatingPlaceholder: false
//                      ),
//                      textInputAction: TextInputAction.done,
//                      initialValue:
//                      userProfileViewModel.userDetails.email,
//                      onSaved: (val) {
//                        userDetailsMap['email'] = val;
//                      },
//                    ),
//                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Phone number:',
                          hasFloatingPlaceholder: false
                      ),
                      textInputAction: TextInputAction.done,
                      initialValue:
                      userProfileViewModel.userDetails.phoneNumber ,
                      onSaved: (val) {
                        userDetailsMap['phoneNumber'] = val;
                      },
                    ),
                  ),



                ]
            ),
          ),
        ),
      ),
    );

         }
  }




