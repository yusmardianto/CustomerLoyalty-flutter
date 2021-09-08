import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'DataType/contents.dart';
import 'api/contents.dart';
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
import "contents_list.dart";

GlobVar globVar;
Util utils = new Util();
SharedPreferences prefs;
String preLoadState;
double preLoadPercentage;
NumberFormat numberFormat = NumberFormat.decimalPattern('id');
GlobalKey<NavigatorState> navKey = new GlobalKey<NavigatorState>();
RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
List<Content> featureList = [];

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
    AppUpdateInfo _updateInfo;
    _updateInfo = await InAppUpdate.checkForUpdate();
    if(_updateInfo?.updateAvailability == 2){
      utils.toast("Mendownload Aplikasi terbaru");
      await utils.showLoadingFuture(context,InAppUpdate.startFlexibleUpdate());
      await installUpdate();
    }
  }
  catch(e){
    print(e);
  }
}
fetchFeatures()async{
  try{
    var res = await ContentApi().getContents("FEATURES");
    if (res["STATUS"] == 1) {
      featureList.clear();
      for (var i = 0; i < res["DATA"].length; i++) {
        featureList.add(Content.fromJson(res["DATA"][i]));
      }
    } else {
      throw ('Error fetching features!');
    }
  }catch(e){
    print("error $e");
  }
}
preload()async{
    try{
      if(prefs==null)prefs = await SharedPreferences.getInstance();
    }
    catch(e){
      print("error, $e");
    }
    if(globVar==null){
    globVar = new GlobVar();
    await utils.restoreGlobVar();
    if(prefs.getBool("first_time")??true){
      await fetchFeatures();
    }
    await Future.delayed(Duration(seconds: 2));
    }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      child: MaterialApp(
        navigatorKey: navKey,
        navigatorObservers: [routeObserver],
        debugShowCheckedModeBanner: false,
        title: 'MyThamrin Club',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Colors.transparent,
          ),
          pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              }
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
              return ((prefs.getBool("first_time")??true)&&featureList.length!=0)?FirstPage(featureList):(globVar.user!=null)?HomePage():LoginPage();
            }
          },
        ),
        routes: {
          '/login': (context) => new LoginPage(),
          '/home' : (context) => new HomePage(),
          '/profile' : (context) => new Profile(),
          '/transactions' : (context) => new Transactions(),
          '/vouchers' :(context) => new VouchersList(),
          '/news' :(context) => new ContentList(),
        },
      ),
    );
  }
}