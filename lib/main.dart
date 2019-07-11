import 'package:firebase_auth/firebase_auth.dart';
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

import 'auth/auth_screen.dart';
import 'auth/register_screen.dart';

void main() async {
  // keep portrait mode always enabled
  await SystemChrome.setPreferredOrientations([
   // DeviceOrientation.portraitUp,
   // DeviceOrientation.portraitDown
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
        buttonColor: Colors.deepOrange,
      ),
      routes: {
        Routes.login:(context) => LoginScreen(),
        Routes.register:(context) => RegisterPage(),
      },
//      home: LoginScreen(),
      home: HomeScreen(),
//      home: _handleCurrentScreen(),
    );
  }

  _handleCurrentScreen() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Animatie de incarcare
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
        } else {          if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return LoginScreen(); // De modificat cu sscreenul de login
        }
        }
      },
    );
  }
}
