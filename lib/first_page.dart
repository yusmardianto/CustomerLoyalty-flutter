import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CustomShape/circle_tab_indicator.dart';
import 'Util/glob_var.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'main.dart';
import 'CustomShape/splash_screen.dart';

class FirstPage extends StatefulWidget {

  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  flex: 10,
                  child: Container(),
                ),
                Flexible(
                  flex:1,
                  child: Container(
                      width: 61,
                      child:
                      Stack(
                        children: [
                          Positioned.fill(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(196, 196, 196, 1),
                                      shape: BoxShape.circle
                                  ),
                                ),
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(196, 196, 196, 1),
                                      shape: BoxShape.circle
                                  ),
                                ),
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(196, 196, 196, 1),
                                      shape: BoxShape.circle
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            controller: _controller,
                            indicator: CircleTabIndicator(color: Color.fromRGBO(0, 0, 52, 1), radius: 6),
                            tabs: [
                              Container(
                                width: 13,
                                height: 13,
                              ),
                              Container(
                                width: 13,
                                height: 13,
                              ),
                              Container(
                                width: 13,
                                height: 13,
                              ),
                            ],
                          ),
                        ],
                      )

                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: TabBarView(
              controller: _controller,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 194,
                        width: 358,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/step1.png'),
                            fit: BoxFit.fitHeight
                          )
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(25),
                        child:Text('Earn Points',style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontWeight: FontWeight.w700,fontSize: 35,shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                        ]),)
                      ),
                      Container(
                          padding: EdgeInsets.all(15),
                          child:Text('Gain Points by Purchasing \nOur Product',textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontWeight: FontWeight.w400,fontSize: 25),)
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 194,
                        width: 358,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/step2.png'),
                                fit: BoxFit.fitHeight
                            )
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(25),
                          child:Text('Redeem Points',style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontWeight: FontWeight.w700,fontSize: 35,shadows: [
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ]),)
                      ),
                      Container(
                          padding: EdgeInsets.all(15),
                          child:Text(' Trade Points With Voucher \nTo Get Better Deals',textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontWeight: FontWeight.w400,fontSize: 25,),)
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 194,
                              width: 358,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/step3.png'),
                                      fit: BoxFit.fitHeight
                                  )
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.all(25),
                                child:Text('Latest Info',style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontWeight: FontWeight.w700,fontSize: 35,),)
                            ),
                            Container(
                                padding: EdgeInsets.all(15),
                                child:Text(' Get Latest News And Deals \nFrom Our Company',textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontWeight: FontWeight.w400,fontSize: 25,),)
                            ),
                          ],
                        ),
                      ),
                      Positioned.fill(child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: ()async{
                                await prefs.setBool("first_time", false);
                                await Navigator.pushReplacementNamed(context, '/login');
                              },
                              child: Container(padding: EdgeInsets.all(25),child: Text('Let\'s get started',style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),decoration: TextDecoration.underline,fontWeight: FontWeight.w400,fontSize: 16,),)))
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}