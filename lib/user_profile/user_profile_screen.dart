import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/user_profile/user_profile_actions.dart';
import 'package:news/user_profile/user_profile_view_model.dart';

class UserProfileScreen extends StatelessWidget {
  Widget tile(String _title, String _value, double _fontSize, bool isCompleted) {
    return Visibility(
      visible: isCompleted,
      child: ListTile(
        title: Text(
          _title,
          style: TextStyle(
              fontSize: _fontSize,
              fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          _value,
          style: TextStyle(
            fontSize: _fontSize * 1.1,
            fontWeight: FontWeight.w500,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 30.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StoreConnector<AppState, UserProfileViewModel> (
        converter: (store) => UserProfileViewModel.fromStore(store),

        builder: (context, userProfileViewModel) =>
            _content(context, _screenHeight, userProfileViewModel),

        onInit: (store) => store.dispatch(GetProfileAction()),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/editProfile');
        },
        child: Icon(Icons.edit),
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _content(BuildContext context, double _screenHeight, UserProfileViewModel userProfileViewModel) =>
      CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                userProfileViewModel.userDetails.name ?? '',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          SliverToBoxAdapter(
            child: Container(
              constraints: BoxConstraints(
                minHeight: _screenHeight
                    - MediaQuery.of(context).padding.top
                    - AppBar().preferredSize.height,
              ),
              child: Column(
                children: <Widget>[
                  tile(
                    'Name',
                    userProfileViewModel.userDetails.name ?? '',
                    _screenHeight * 0.02,
                    userProfileViewModel.userDetails.name != null,
                  ),
                  tile(
                    'Email',
                    userProfileViewModel.userDetails.email ?? '',
                    _screenHeight * 0.02,
                    userProfileViewModel.userDetails.email != null,
                  ),
                  tile(
                    'Phone Number',
                    userProfileViewModel.userDetails.phoneNumber ?? '',
                    _screenHeight * 0.02,
                    userProfileViewModel.userDetails.phoneNumber != null,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
