import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'CustomShape/wave_shaper.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: WavePainter(),
              ),
            ),
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 1,child: SizedBox()),
                      Expanded(
                        flex: 5,
                        child: Stack(
                          children: [
                            Container(
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                              child: Icon(Icons.person,color: Colors.white,size: 160,),
                            ),
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white,width: 3)
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text("{#Name BLABLA}",style: TextStyle(color: Colors.white,fontSize: 16,fontStyle: FontStyle.italic,fontWeight: FontWeight.w700),),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: FlatButton(
                          onPressed: (){},
                          minWidth: 180,
                          padding: EdgeInsets.all(12),
                          color: Color.fromRGBO(255, 84, 84, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.pencilAlt,color: Colors.white,size: 18,),
                              Text(" Edit Profile",style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.w700),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(33),
                    itemCount: 4,
                      itemBuilder: (context,idx)=>Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 22.5,left: 45,right: 45,bottom: 22.5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("FULL NAME",style: TextStyle(fontSize: 14,fontStyle: FontStyle.italic,fontWeight: FontWeight.w700,color: Color.fromRGBO(146, 146, 146, 1)),),
                                  Text("Lucas Steinfield",style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w700,color: Colors.black.withOpacity(0.6))),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                      ))
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}