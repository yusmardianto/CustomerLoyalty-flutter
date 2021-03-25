import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Util/glob_var.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'main.dart';
import 'CustomShape/splash_screen.dart';

class FirstPage extends StatefulWidget {

  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  preload()async{

    setState(() {
      preLoadState = "Mempersiapkan data";
    });
    if(prefs==null)prefs = await SharedPreferences.getInstance();
    // print('test${[globVar==null,prefs==null,prefs.getString("user")]}');
    if(globVar==null){
      setState(() {
        preLoadState = "Mengecek penyimpanan";
      });
      globVar = new GlobVar();
      setState(() {
        preLoadPercentage = 1/2;
      });
      await utils.restoreGlobVar();
      setState(() {
        preLoadState = "Hampir selesai";
        preLoadPercentage = 2/2-0.02;
      });
      await Future.delayed(Duration(seconds: 2));
    }
  }

  @override
  void initState() {
    preLoadPercentage =0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: preload(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return (globVar.user!=null)?HomePage():LoginPage();
          } else {
            return Splashscreen(preLoadPercentage,preLoadState);
          }
        });
  }
}