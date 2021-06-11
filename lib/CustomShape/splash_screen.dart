import 'dart:async';
import 'package:flutter/material.dart';
import '../main.dart';
import 'round_shaper.dart';

class Splashscreen extends StatefulWidget {
  double _percentage;
  String _state;
  // Splashscreen(this._percentage,this._state);
  Splashscreen({Key key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  // Timer step;
  // double percentage = 0;
  // String state = "Mempersiapkan data";
  @override
  void initState() {
    // state = this.state;
    // percentage = this.percentage;
    // step = Timer.periodic(Duration(seconds: 1), (timer){
    //   if(percentage >= 1){
    //     setState(() {
    //       state = "Memulai aplikasi";
    //       timer.cancel();
    //       step.cancel();
    //     });
    //   }
    //   else{
    //     if (percentage!=null&&percentage<=preLoadPercentage){
    //       percentage = preLoadPercentage;
    //       state = preLoadState;
    //     }
    //     setState(() {
    //       percentage = percentage +0.01;
    //     });
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Colors.white,
        decoration: BoxDecoration(
          image:DecorationImage(
            image: AssetImage("images/splash.jpg"),
            fit: BoxFit.fill
          )
        ),
      ),
    );
  }
  @override
  void dispose() {
    // step.cancel();
    super.dispose();
  }
}