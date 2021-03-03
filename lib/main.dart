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

// Images imageHandler = new Images();
GlobaVar globVar = new GlobaVar();
Util utils = new Util();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await globVar.initGlobVar();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_)async {
          runApp(new MyApp());
      });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        home: (globVar.user!=null)?HomePage():LoginPage(),
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
}