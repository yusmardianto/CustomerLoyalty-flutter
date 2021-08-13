import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  Splashscreen({Key key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
    super.dispose();
  }
}