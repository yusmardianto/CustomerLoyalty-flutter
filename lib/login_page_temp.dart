import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import './CustomShape/round_shaper.dart';
import 'dart:ui' as ui;
import 'main.dart';
import "api/auths.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "DataType/user.dart";

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
                  Center(child: Text("Sudah ingin keluar ?",style: TextStyle(fontStyle: FontStyle.normal,fontSize: 14,fontWeight: FontWeight.w300),)),
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
                          child: Text("Tutup",style: TextStyle(fontStyle: FontStyle.normal,fontSize: 18,fontWeight: FontWeight.w500),)
                      ),
                      SizedBox(width: 15),
                      FlatButton(
                          minWidth: 120,
                          color: Color.fromRGBO(254, 83, 83, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          padding: EdgeInsets.all(10),
                          onPressed: ()async {
                            try{
                              await utils.backupGlobVar();
                            }
                            catch(e){
                              utils.toast(e);
                            }
                            Navigator.pop(context,true);
                          },
                          child: Text("Keluar",style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal,fontSize: 18,fontWeight: FontWeight.w500),)
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
          padding: const EdgeInsets.all(25.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.04,),
              Container(
                width: 364,
                height:367,
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage("images/login_icon.png"),
                //     fit: BoxFit.fitWidth
                //   )
                // ),
              ),
              Container(
                padding: EdgeInsets.only(top:15),
                child: Text("Selamat Bergabung\ndalam\nThamrin Club",textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: Color.fromRGBO(0, 0, 52, 1)),),
              ),
              Container(
                padding: EdgeInsets.only(top:15),
                child: Text("Kesetiaan dan kepuasan pelanggan adalah prioritas kami",textAlign: TextAlign.center,style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,fontWeight: FontWeight.w400,color: Color.fromRGBO(0, 0, 52, 1)),),
              ),
              // Expanded(
              //  child:
              // )
            ],
          ),
        ),
      ),
    );
  }
}