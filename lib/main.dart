import 'package:flutter/material.dart';
import 'login_page.dart';
// import './Util/image_fetch.dart';
import 'home_page.dart';
import 'profile.dart';
import 'Util/glob_var.dart';

// Images imageHandler = new Images();
GlobaVar globVar = new GlobaVar();

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Customer Loyalty',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Colors.transparent,
        ),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      routes: {
        '/login': (context) => new LoginPage(),
        '/home' : (context) => new HomePage(),
        '/profile' : (context) => new Profile(),
      },
    );
  }
}