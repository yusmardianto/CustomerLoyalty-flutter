import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'profile.dart';
import 'Util/glob_var.dart';
import 'Util/utils.dart';
import 'Util/life_cycle_manager.dart';
import 'transactions.dart';
import 'vouchers_list.dart';
import 'CustomShape/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

// Images imageHandler = new Images();
GlobaVar globVar;
Util utils = new Util();
SharedPreferences prefs;
String preLoadState;
double preLoadPercentage;
Intl intl = new Intl();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_)async {
          runApp(new MyApp());
      });
}

Future preload()async{
  preLoadState = "Mempersiapkan data";
  await Future.delayed(Duration(seconds: 1));
  preLoadState = "Mengecek penyimpanan";
  prefs = await SharedPreferences.getInstance();
  preLoadPercentage = 1/2;
  await Future.delayed(Duration(seconds: 1));
  preLoadState = "Hampir selesai";
  globVar = new GlobaVar();
  preLoadPercentage = 2/2-0.02;
  await Future.delayed(Duration(seconds: 2));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: preload(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Splashscreen(preLoadPercentage,preLoadState));
        } else {
          // Loading is done, return the app:
          return LifeCycleManager(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Customer Loyalty',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                bottomSheetTheme: BottomSheetThemeData(
                  backgroundColor: Colors.transparent,
                ),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: (prefs.getString("user")!=null)?HomePage():LoginPage(),
              routes: {
                '/login': (context) => new LoginPage(),
                '/home' : (context) => new HomePage(),
                '/profile' : (context) => new Profile(),
                '/transactions' : (context) => new Transactions(),
                '/vouchers' :(context) => new VouchersList(),
              },
            ),
          );
        }
      },
    );
  }
}