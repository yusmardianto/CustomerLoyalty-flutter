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
        // child: Stack(
        //   children: [
        //     Container(
        //       height: MediaQuery.of(context).size.height,
        //       width: MediaQuery.of(context).size.width,
        //       child: CustomPaint(
        //         painter: RoundPainter(),
        //       ),
        //     ),
        //     Column(
        //       children: [
        //         Container(
        //           height: MediaQuery.of(context).size.height*0.44,
        //           padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.16,left: MediaQuery.of(context).size.width*0.24,right: MediaQuery.of(context).size.width*0.24,bottom: MediaQuery.of(context).size.height*0.05),
        //           child: Container(
        //             height: 218,
        //             width: 205,
        //             decoration: BoxDecoration(
        //                 image: DecorationImage(
        //                   image: AssetImage("images/icon.png"),
        //                   // colorFilter: ColorFilter.mode(Color.fromRGBO(10, 10, 249, 0.5), BlendMode.modulate ),
        //                   fit: BoxFit.fitHeight,
        //                 )
        //             ),
        //           ),
        //         ),
        //         Container(
        //           child: Text("Customer Loyalty",style: TextStyle(color: Colors.black.withOpacity(0.75),fontSize: 28,fontWeight: FontWeight.w700, fontFamily: "Roboto",fontStyle: FontStyle.normal),),),
        //         Container(
        //           child: Text("You don't earn loyalty in a day",style: TextStyle(color: Colors.black.withOpacity(0.75),fontSize: 16,fontWeight: FontWeight.w300, fontFamily: "Roboto",fontStyle: FontStyle.normal),),),
        //         Expanded(
        //           child: Center(
        //             child: Column(
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 Text(state,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
        //                 SizedBox(height: 10,),
        //                 Container(
        //                   width: MediaQuery.of(context).size.width*0.5,
        //                     child: LinearProgressIndicator(
        //                       value: percentage,
        //                     )),
        //                 SizedBox(height: 10,),
        //                 Text("${(percentage*100).toStringAsFixed(0)}%",style: TextStyle(fontSize: 21,),)
        //               ],
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   ],
        // ),
      ),
    );
  }
  @override
  void dispose() {
    // step.cancel();
    super.dispose();
  }
}