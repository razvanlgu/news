import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/page/page_screen.dart';
import 'package:news/ui/users_screen.dart';
import 'package:news/user_profile/edit_profile_screen.dart';
import 'package:news/user_profile/user_profile_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:news/redux/appstate.dart';
import 'package:news/redux/store.dart';
import 'package:news/resources/keys.dart';
import 'package:news/resources/constants.dart';
import 'package:news/home/home_screen.dart';

import 'add_news/add_news_screen.dart';
import 'auth/auth_screen.dart';
import 'auth/register_screen.dart';
import 'map/map_screen.dart';

void main() async {
  // keep portrait mode always enabled
  await SystemChrome.setPreferredOrientations([
   DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown
  ]);

  // Store initialization
  final Store<AppState> store = await createStore();

  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {

  final Store<AppState> store;

  // Constructor
  MyApp(this.store);

  // Builder
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: mainMaterialApp(),
    );
  }

  Widget mainMaterialApp() {
    return MaterialApp(
      navigatorKey: Keys.navKey,
      title: 'News',

      // Theme
      theme: ThemeData(
        hintColor: NewsColors.textBorderColorEnabled,

        // Theme for AppBar
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          color: NewsColors.textBorderColorEnabled,
        ),

        // Theme for text input
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: NewsColors.textBorderColorEnabled,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 17.0),
          hasFloatingPlaceholder: false,
          filled: true,
          fillColor: NewsColors.textFillColorFocused,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: NewsColors.textBorderColorFocused, width: 4.0),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: NewsColors.textBorderColorEnabled, width: 3.0),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
        ),

        // Theme for buttons
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          buttonColor: NewsColors.textBorderColorFocused,
          textTheme: ButtonTextTheme.primary
        ),
      ),
      routes: {
        Routes.login:(context) => LoginScreen(),
        Routes.register:(context) => RegisterPage(),
        Routes.home:(context) => HomeScreen(),
        Routes.addNews:(context) => AddNewsScreen(),
        Routes.profile:(context) => UserProfileScreen(),
        Routes.editProfile:(context) => EditUserProfileScreen(),
        Routes.map:(context) => MapScreen(),
        Routes.newsPage:(context) => PageScreen(),
        Routes.users:(context) => UsersPageScreen(),
      },

      home: _handleCurrentScreen(),
    );
  }

  _handleCurrentScreen() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {

          return Scaffold(
            body: Center(
              child: Theme(
                data: Theme.of(context).copyWith(
                  accentColor: Theme.of(context).primaryColor,
                ),
                child: SpinKitFadingCube(
                  size: 100,
                  itemBuilder: (_, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).accentColor,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        } else {
          if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
        }
      },
    );
  }
}
