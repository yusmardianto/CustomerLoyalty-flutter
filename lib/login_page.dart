import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './CustomShape/round_shaper.dart';
import 'dart:ui' as ui;
import 'main.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ui.Image assetImage;

  @override
  void initState() {
    // imageHandler.load('images/d.jpg').then((i){
    //   setState(() {
    //     assetImage = i;
    //   });
    // });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: ()async{
          var exit = await showDialog(
              context: context,
              builder: (context)=>SimpleDialog(
                children: [
                  Icon(Icons.meeting_room,size: 85,),
                  Center(child: Text("Sudah ingin keluar ?",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 14,fontWeight: FontWeight.w300),)),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                          minWidth: 120,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Color.fromRGBO(64, 64, 222, 1))
                          ),
                          padding: EdgeInsets.all(10),
                          onPressed: (){
                            Navigator.pop(context,false);
                          },
                          child: Text("Tutup",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.w500),)
                      ),
                      SizedBox(width: 15),
                      FlatButton(
                          minWidth: 120,
                          color: Color.fromRGBO(254, 83, 83, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          padding: EdgeInsets.all(10),
                          onPressed: (){
                            Navigator.pop(context,true);
                          },
                          child: Text("Keluar",style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.w500),)
                      ),
                    ],
                  ),
                ],
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: Colors.transparent)
                ),
                contentPadding: EdgeInsets.all(20),
              )
          );
          if(exit??false){
            SystemNavigator.pop();
          }
          return false;
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CustomPaint(
                  painter: RoundPainter(),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.44,
                    padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.16,left: MediaQuery.of(context).size.width*0.24,right: MediaQuery.of(context).size.width*0.24,bottom: MediaQuery.of(context).size.height*0.05),
                    child: Container(
                      height: 218,
                      width: 205,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/icon.png"),
                          // colorFilter: ColorFilter.mode(Color.fromRGBO(10, 10, 249, 0.5), BlendMode.modulate ),
                          fit: BoxFit.fitHeight,
                        )
                      ),
                    ),
                  ),
                  Container(
                    child: Text("Customer Loyalty",style: TextStyle(color: Colors.black.withOpacity(0.75),fontSize: 28,fontWeight: FontWeight.w700, fontFamily: "Roboto",fontStyle: FontStyle.italic),),),
                  Container(
                    child: Text("You don't earn loyalty in a day",style: TextStyle(color: Colors.black.withOpacity(0.75),fontSize: 16,fontWeight: FontWeight.w300, fontFamily: "Roboto",fontStyle: FontStyle.italic),),),
                  Expanded(
                   child: Padding(
                     padding: EdgeInsets.only(bottom: 115),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Container(
                           width: 286,
                           child: FlatButton(
                               color: Color.fromRGBO(64, 64, 222, 1),
                               shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                               padding: EdgeInsets.all(12),
                               onPressed: (){
                                 showModalBottomSheet(
                                   isScrollControlled: true,
                                   context: context,
                                   builder: (context) => Container(
                                     padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                     height: MediaQuery.of(context).size.height*0.8,
                                     decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                                     ),
                                     child: SingleChildScrollView(
                                       scrollDirection: Axis.vertical,
                                       child: Column(
                                         mainAxisSize: MainAxisSize.min,
                                         children: [
                                           Container(
                                             height: MediaQuery.of(context).size.height*0.38,
                                             padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.10,left: MediaQuery.of(context).size.width*0.24,right: MediaQuery.of(context).size.width*0.24,bottom: MediaQuery.of(context).size.height*0.03),
                                             child: Container(
                                               height: 218,
                                               width: 205,
                                               decoration: BoxDecoration(
                                                   image: DecorationImage(
                                                     image: AssetImage("images/icon.png"),
                                                     // colorFilter: ColorFilter.mode(Color.fromRGBO(10, 10, 249, 0.5), BlendMode.modulate ),
                                                     fit: BoxFit.fitHeight,
                                                   )
                                               ),
                                             ),
                                           ),
                                           Padding(
                                             padding: const EdgeInsets.only(left:53,right: 53),
                                             child: Column(
                                               children: [
                                                 Padding(
                                                   padding: const EdgeInsets.only(top: 50),
                                                   child: TextField(
                                                     decoration: InputDecoration(
                                                         focusedBorder: new OutlineInputBorder(
                                                           borderSide: BorderSide(color: Color.fromRGBO(64, 64, 222, 1)),
                                                           borderRadius: const BorderRadius.all(
                                                             const Radius.circular(15.0),
                                                           ),
                                                         ),
                                                       border: new OutlineInputBorder(
                                                         borderRadius: const BorderRadius.all(
                                                           const Radius.circular(15.0),
                                                         ),
                                                       ),
                                                       contentPadding: EdgeInsets.all(23),
                                                       hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,fontStyle: FontStyle.italic),
                                                       hintText: "Alamat Email"
                                                     ),
                                                   ),
                                                 ),
                                                 Padding(
                                                   padding: const EdgeInsets.only(top: 20,),
                                                   child: TextField(
                                                     decoration: InputDecoration(
                                                         focusedBorder: new OutlineInputBorder(
                                                           borderSide: BorderSide(color: Color.fromRGBO(64, 64, 222, 1)),
                                                           borderRadius: const BorderRadius.all(
                                                             const Radius.circular(15.0),
                                                           ),
                                                         ),
                                                         border: new OutlineInputBorder(
                                                           borderRadius: const BorderRadius.all(
                                                             const Radius.circular(15.0),
                                                           ),
                                                         ),
                                                         contentPadding: EdgeInsets.all(23),
                                                         hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,fontStyle: FontStyle.italic),
                                                         hintText: "Password"
                                                     ),
                                                   ),
                                                 ),
                                                 Container(
                                                   padding: EdgeInsets.only(top:15),
                                                   alignment: Alignment.centerRight,
                                                   child: Text("Lupa Password",style: TextStyle(fontWeight: FontWeight.w200,decoration: TextDecoration.underline,color: Color.fromRGBO(5,0,255,1),fontSize: 16,fontStyle: FontStyle.italic,),),
                                                 ),
                                                 Container(
                                                   padding: EdgeInsets.only(top: 25),
                                                   width: 286,
                                                   child: FlatButton(
                                                       color: Color.fromRGBO(64, 64, 222, 1),
                                                       shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                                                       padding: EdgeInsets.all(12),
                                                       onPressed: (){
                                                         Navigator.pushReplacementNamed(context, "/home");
                                                       },
                                                       child: Text("Login",style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.italic,fontSize: 24,color: Colors.white),)),
                                                 ),
                                               ],
                                             ),
                                           ),

                                         ],
                                       ),
                                     ),
                                   )
                                 );
                               },
                               child: Text("Login",style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.italic,fontSize: 24,color: Colors.white),)),
                         ),
                         Container(
                           padding: const EdgeInsets.only(top: 15),
                           width: 286,
                           child: FlatButton(
                               color: Colors.white,
                               padding: EdgeInsets.all(12),
                               shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0),side: BorderSide(width: 2,color: Color.fromRGBO(133, 131, 249, 1))),
                               onPressed: (){

                               },
                               child: Container(
                                 alignment: Alignment.center,
                                 child: Text("Daftar",style: TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.italic,fontSize: 24,color: Colors.black),),
                               )),
                         ),
                       ],
                     ),
                   ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}