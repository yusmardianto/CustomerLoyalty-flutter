import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
import 'package:in_app_update/in_app_update.dart';
import 'first_page.dart';

// Images imageHandler = new Images();
GlobVar globVar;
Util utils = new Util();
SharedPreferences prefs;
String preLoadState;
double preLoadPercentage;
NumberFormat numberFormat = NumberFormat.decimalPattern('id');
GlobalKey<NavigatorState> navKey = new GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences.setMockInitialValues({});
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_)async {
          runApp(new MyApp());
      });
}

_check_Update(context)async{
  try{
    print("checking update");
    installUpdate()async{
      utils.toast("Installing");
      await InAppUpdate.completeFlexibleUpdate();
    }
    // final PackageInfo info = await PackageInfo.fromPlatform();
    // setState(() {
    //   curentVers = info.version;
    // });
    AppUpdateInfo _updateInfo;
    _updateInfo = await InAppUpdate.checkForUpdate();
    // print("update  ${_updateInfo.updateAvailability}");
    // utils.toast("test ${_updateInfo.updateAvailability}");
    if(_updateInfo?.updateAvailability == 2){
      // String currentVersion = info.version.trim();
      // String latestversion = '0.0.0';
      // var result = await util.getSettingParams('MOBILE_APP_VERSION');
      // if(result['STATUS']=='SUCCESS'){
      //   latestversion = result['DATA'];
      // }
//       print([currentVersion,latestversion]);
//       var current = currentVersion.split('.');
//       var latest = latestversion.split('.');
//       if(int.parse(current[0])==int.parse(latest[0])){
//         if(int.parse(current[1])==int.parse(latest[1])){
//           if(int.parse(current[2])<int.parse(latest[2])) {
//             await util.updateDialog(context);
// //              await InAppUpdate.performImmediateUpdate();
//           }
//           else{
//             await InAppUpdate.startFlexibleUpdate();
//             await InAppUpdate.completeFlexibleUpdate();
//           }
//         }
//         else if(int.parse(current[1])<int.parse(latest[1])) {
//           await util.updateDialog(context);
// //            await InAppUpdate.performImmediateUpdate();
//         }
//         else{
//           await InAppUpdate.startFlexibleUpdate();
//           await InAppUpdate.completeFlexibleUpdate();
//         }
//       }
//       else if(int.parse(current[0])<int.parse(latest[0])) {
//         await util.updateDialog(context);
// //          await InAppUpdate.performImmediateUpdate();
//       }
//       else{
      utils.toast("Mendownload Aplikasi terbaru");
      await utils.showLoadingFuture(context,InAppUpdate.startFlexibleUpdate());
      await installUpdate();      // }
    }
  }
  catch(e){
    print(e);
    // utils.toast("Error, $e");
    // await Future.delayed(Duration(milliseconds: 500));
    // await utils.launchBrowserURL(globVar.playStore);
//      util.showFlushbar(context, "Failed checking updates. $e.");
  }
}
preload()async{
    // preLoadState = "Mempersiapkan data";
    try{
      if(prefs==null)prefs = await SharedPreferences.getInstance();
    }
    catch(e){
      print("error, $e");
    }
    if(globVar==null){
    // preLoadState = "Mengecek penyimpanan";
    globVar = new GlobVar();
    // preLoadPercentage = 1/2;
    await utils.restoreGlobVar();
/*    preLoadState = "Hampir selesai";
    preLoadPercentage = 2/2-0.02;*/
    await Future.delayed(Duration(seconds: 2));
    }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      child: MaterialApp(
        navigatorKey: navKey,
        debugShowCheckedModeBanner: false,
        title: 'MyThamrin Club',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Colors.transparent,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder(
          future: preload(),
          builder: (context, AsyncSnapshot snapshot) {
            // Show splash screen while waiting for app resources to load:
            if (snapshot.connectionState == ConnectionState.waiting) {
              // return Splashscreen(preLoadPercentage,preLoadState);
              return Splashscreen();
            } else {
              // Loading is done, return the app:
              _check_Update(context);
              if(prefs.getBool("first_time")??true){
                return FirstPage();
              }
              else return (globVar.user!=null)?HomePage():LoginPage();
            }
          },
        ),
        routes: {
          '/login': (context) => new LoginPage(),
          '/home' : (context) => new HomePage(),
          '/profile' : (context) => new Profile(),
          '/transactions' : (context) => new Transactions(),
          '/vouchers' :(context) => new VouchersList(),
          // '/news' :(context) => new News(),
        },
      ),
    );
    // return FutureBuilder(
    //   future: _initFuture,
    //   builder: (context, AsyncSnapshot snapshot) {
    //     // Show splash screen while waiting for app resources to load:
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return MaterialApp(home: Splashscreen(preLoadPercentage,preLoadState));
    //     } else {
    //       // Loading is done, return the app:
    //       return LifeCycleManager(
    //         child: MaterialApp(
    //           debugShowCheckedModeBanner: false,
    //           title: 'Customer Loyalty',
    //           theme: ThemeData(
    //             primarySwatch: Colors.blue,
    //             bottomSheetTheme: BottomSheetThemeData(
    //               backgroundColor: Colors.transparent,
    //             ),
    //             visualDensity: VisualDensity.adaptivePlatformDensity,
    //           ),
    //           home: (globVar.user!=null)?HomePage():LoginPage(),
    //           routes: {
    //             '/login': (context) => new LoginPage(),
    //             '/home' : (context) => new HomePage(),
    //             '/profile' : (context) => new Profile(),
    //             '/transactions' : (context) => new Transactions(),
    //             '/vouchers' :(context) => new VouchersList(),
    //             // '/news' :(context) => new News(),
    //           },
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}