


import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/auth/auth_view_model.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/resources/constants.dart';
import 'package:news/user_profile/user_profile_actions.dart';


class NewsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StoreConnector<AppState, AuthViewModel>(
        converter: (store) => AuthViewModel.fromStore(store),
        onInit: (store) => store.dispatch(GetProfileAction()),
        builder: (context, authViewModel) => _content(context, authViewModel),
      ),
      );

  }
  Widget _content(BuildContext context, AuthViewModel authViewModel) {

    Widget _drawerTile(
        {String route, String name, IconData icon, VoidCallback onTap}) {
      return Material(
        // color:
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 25, 0, 25),
          child: InkWell(
            splashColor: Colors.deepOrangeAccent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  //  color:
                  size: 20.0,
                ),
                Text(
                  name,
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
                height: MediaQuery.of(context).size.height/4,
                decoration: BoxDecoration(
               // backgroundBlendMode: BlendMode.clear,
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
                          Text('${authViewModel.email}'),
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
            height: MediaQuery.of(context).size.height*3/4,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child:Column(
                children: <Widget>[
                  _drawerTile(
                      route:Routes.home,
                      name:'News',
                      icon:Icons.library_books
                  ) ,
//

                   _drawerTile(
                     route:Routes.map,
                     name:'News Map',
                     icon:Icons.map
                   ) ,
//
                  Container(
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

