import 'package:flutter/material.dart';
import 'CustomShape/diagonal_shaper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                painter: DiagonalPainter(),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                Padding(
                  padding: const EdgeInsets.only(top: 15,right: 18,left: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("Home",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 24),),
                      ),
                      Container(
                        child: Icon(FontAwesomeIcons.bell,color: Colors.white,size: 24,),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15,right: 18,left: 18),
                  child: Container(
                    child: Text("Your Points :",style: TextStyle(shadows: [
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 0.5,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ],color: Colors.white,fontStyle: FontStyle.italic,fontWeight: FontWeight.w500,fontSize: 18),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15,right: 18,left: 68),
                  child: Row(
                    children: [
                      Container(
                        child: Text("18000",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18, fontFamily: "PT_Mono"),),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text("pts",style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,fontWeight: FontWeight.w300,fontSize: 16, fontFamily: "PT_Mono"),),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: CarouselSlider(
                    options: CarouselOptions(height: 155.0),
                    items: [1,2,3,4,5].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 155,
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(1.0,1.0),
                                      color: Colors.grey,
                                      blurRadius: 3
                                    )
                                  ],
                                  color: Color.fromRGBO(237, 237, 237, 1)
                              ),
                          );
                        },
                      );
                    }).toList(),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15,right: 18,left: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("My Vouchers :",style: TextStyle(shadows: [
                          Shadow(
                            offset: Offset(3.0, 3.0),
                            blurRadius: 0.5,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ],color: Colors.white,fontStyle: FontStyle.italic,fontWeight: FontWeight.w500,fontSize: 18),),
                      ),
                      Container(
                        child: Text("Show all",style: TextStyle(
                            shadows: [
                              Shadow(
                                offset: Offset(3.0, 3.0),
                                blurRadius: 0.5,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ],
                            decoration: TextDecoration.underline,
                            color: Colors.white,fontStyle: FontStyle.italic,fontWeight: FontWeight.w700,fontSize: 14),),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15,right: 18,left: 18),
                  child: Container(
                    height: 152,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(237, 237, 237, 1)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25,right: 18,left: 18),
                  child: Container(
                    height: 152,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(237, 237, 237, 1)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15,right: 18,left: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("Products on promotion sales :",style: TextStyle(shadows: [
                          Shadow(
                            offset: Offset(3.0, 3.0),
                            blurRadius: 0.5,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ],color: Colors.white,fontStyle: FontStyle.italic,fontWeight: FontWeight.w500,fontSize: 18),),
                      ),
                      Container(
                        child: Text("Show all",style: TextStyle(
                            shadows: [
                              Shadow(
                                offset: Offset(3.0, 3.0),
                                blurRadius: 0.5,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ],
                            decoration: TextDecoration.underline,
                            color: Colors.white,fontStyle: FontStyle.italic,fontWeight: FontWeight.w700,fontSize: 14),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}