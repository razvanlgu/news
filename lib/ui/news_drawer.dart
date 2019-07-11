


import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/auth/auth_view_model.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/resources/constants.dart';


class NewsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StoreConnector<AppState, AuthViewModel>(
        converter: (store) => AuthViewModel.fromStore(store),
       // onInit: (store) => store.dispatch(FetchProfileAction()),
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
          padding: const EdgeInsets.fromLTRB(8, 20, 0, 0),
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
              Navigator.pop(context);
              Navigator.pushNamed(context, route);
            }
                : onTap,
          ),
        ),
      );
    }
    return ListView(
        children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/4,
                //child:Text('Header'),
                decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.clear,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  colorFilter:  ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  image:  NetworkImage(
                  'https://learnenglishorstarve.files.wordpress.com/2017/06/news-tsodotcom.jpg',
                  ),
                 ),
                color: Colors.white,

              )
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
                     route:Routes.login,
                     name:'Log In',
                     icon:Icons.account_circle
                   ) ,
                  _drawerTile(
                      route:Routes.register,
                      name:'Register',
                      icon:Icons.account_circle
                  ),
                  Container(
                    child: _drawerTile(
                        //route:Routes.login,
                        name:'LogOut',
                      //  icon:Icons.account_circle
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

