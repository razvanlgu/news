


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/auth/auth_view_model.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/resources/constants.dart';
import 'package:news/user_profile/user_details.dart';
import 'package:news/user_profile/user_profile_actions.dart';
import 'package:redux/redux.dart';


class NewsDrawer extends StatefulWidget {
  @override
  _NewsDrawerState createState() => _NewsDrawerState();
}

class _NewsDrawerState extends State<NewsDrawer> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StoreConnector<AppState, AuthViewModel>(
        converter: (store) => AuthViewModel.fromStore(store),
        onInit: _onInit,
        builder: (context, authViewModel) => _content(context, authViewModel),
      ),
      );

  }

  _onInit(Store<AppState> store) async {
    store.dispatch(GetProfileAction());
    check = await checkIfAdmin();
  }

  Widget _content(BuildContext context, AuthViewModel authViewModel) {
double _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).viewInsets.top;
    Widget _drawerTile(
        {String route, String name, IconData icon, VoidCallback onTap}) {
      return Material(
        // color:
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 20, 0, 20),
          child: InkWell(
            splashColor: Colors.deepOrangeAccent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  //  color:
                  size: 30.0,
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            onTap: onTap == null
                ? () {
              //Navigator.pop(context);
              Navigator.pushNamed(context, route);
            }
                : onTap,
          ),
        ),
      );
    }
    return ListView(
        children: <Widget>[
          GestureDetector(
            onTap:() {
              //Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
          },

           child: Container(
                width: MediaQuery.of(context).size.width,
                height: _height/5,
                decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  colorFilter:  ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  image:  NetworkImage(
                  'https://learnenglishorstarve.files.wordpress.com/2017/06/news-tsodotcom.jpg',
                  ),
                 ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left:40,right:50),
                child: Row(
                  children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(right:20),
                     child: CircleAvatar(
                          backgroundImage: NetworkImage('https://www.cropib.com/themes/cropib/assets/images/placeholder/no_image_available.png')
                          ),
                   ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            authViewModel.email == '' ? '${authViewModel.userEmail}' : '${authViewModel.email}',
                            style:DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.3),
                       ),

                          Container(
                            child: FlatButton(onPressed: (){
                              //Navigator.pop(context);
                              Navigator.pushNamed(context, Routes.profile);
                            },
                                child: Text("Edit Profile")
                            ),
                          )
                        ]
                      ),
                  ],
                ),

              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: _height*4/5,
            decoration: BoxDecoration(
            ),
            child:Column(
                children:  <Widget>[
                  _drawerTile(
                      route:Routes.home,
                      name:'News',
                      icon:Icons.library_books
                  ) ,//

                   _drawerTile(
                     route:Routes.map,
                     name:'News Map',
                     icon:Icons.map
                   ) ,
                  check ? _drawerTile(
                  route: Routes.users,
                  name: 'Users',
                  icon: Icons.supervised_user_circle,
                  ) : Container(),
                  Expanded(
                    child: Container(),
                  ),
//
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: _drawerTile(
                      name:'LogOut',
                      icon:Icons.account_circle,
                      onTap:authViewModel.logOut,
                    ),

                  )
                ]
            )
          ),

        ]

    );
  }
}

Future<bool> checkIfAdmin() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  DocumentSnapshot snapshot= await Firestore.instance.collection('users').document(user.uid).get();
  UserDetails userDetails = UserDetails.fromFirebase(snapshot);
  return userDetails.isAdmin;
}
