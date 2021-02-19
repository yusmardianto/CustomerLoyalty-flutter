import 'package:customer_loyalty/Util/glob_var.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'CustomShape/diagonal_shaper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'main.dart';

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
      body: WillPopScope(
        onWillPop: ()async{
            var exit = await showDialog(
                context: context,
                builder: (context)=>SimpleDialog(
                  children: [
                    Icon(Icons.meeting_room,size: 85,),
                    Center(child: Text("Leaving us already ?",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 14,fontWeight: FontWeight.w300),)),
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
                            child: Text("Cancel",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.w500),)
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
                            child: Text("Close",style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 18,fontWeight: FontWeight.w500),)
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
                  painter: DiagonalPainter(),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
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
                          InkWell(
                            onTap: (){
                              setState(() {
                                globVar.isShowNotif = !globVar.isShowNotif;
                              });
                            },
                            child: Container(
                              child: Icon(globVar.isShowNotif ? FontAwesomeIcons.solidBell: FontAwesomeIcons.bellSlash,color: Colors.white,size: 24,),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15,right: 18,left: 18),
                      child: Row(
                        children: [
                          Text("Hi ",style: TextStyle(fontSize:18,color: Colors.white,fontWeight: FontWeight.w300),),
                          Text("Lucas,",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500),)
                        ],
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15,right: 18,left: 18),
                      child: Container(
                        child: Text("Kamu punya \t:",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 16),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15,right: 18,left: 45),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child: Text("Points : ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 14),),
                              ),
                              Container(
                                child: Text("18000",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18, fontFamily: "PT_Mono"),),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Icon(FontAwesomeIcons.coins,size: 18,color:Colors.amberAccent),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child: Text("Level \t: ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 14),),
                              ),
                              Container(
                                child: Text("Besty",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16, fontFamily: "PT_Mono"),),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Icon(FontAwesomeIcons.crown,size: 18,color:Colors.amberAccent),
                              ),
                            ],
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
                    Container(
                      height: (152.0+15)*2,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(right: 18,left: 18),
                        itemCount: 2,
                        itemBuilder: (context,index)=>Padding(
                          padding: EdgeInsets.only(top:15),
                          child: Container(
                            height: 152,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromRGBO(237, 237, 237, 1)
                            ),
                          ),
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
                    Container(
                      height: 200.0*2,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(left: 8,right: 8),
                        itemCount: 4,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemBuilder: (context,indx)=>Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 175,
                              width: 175,
                              child: Card(
                                color: Color.fromRGBO(237, 237, 237, 1),
                                child: new GridTile(
                                  footer: new Text(""),
                                  child: new Text(""), //just for testing, will fill with image later
                                ),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(61,61, 206, 1),
        type : BottomNavigationBarType.fixed,
        onTap: (idx){
          switch(idx){
            case 0 : {

            }break;
            case 1 : {
              Navigator.pushNamed(context, "/profile");
            }break;
            case 2 : {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => Container(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    height: MediaQuery.of(context).size.height*0.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            SizedBox(height: 40,),
                            Container(child: Text("Apa yang mau kita lakukan hari ini ?",style: TextStyle(color: Colors.black),))
                        ],
                      ),
                    ),
                  )
              );
            }break;
            case 3 : {

            }break;
            case 4 : {

            }break;
          }
        },
        items: [
          BottomNavigationBarItem(title: Container(),icon: Icon(FontAwesomeIcons.commentDots,color: Colors.white,)),
          BottomNavigationBarItem(title: Container(),icon: Icon(FontAwesomeIcons.addressCard,color: Colors.white,)),
          BottomNavigationBarItem(title: Container(),icon: Icon(Icons.widgets_outlined,color: Colors.white,)),
          BottomNavigationBarItem(title: Container(),icon: Icon(FontAwesomeIcons.gift,color: Colors.white,)),
          BottomNavigationBarItem(title: Container(),icon: Icon(FontAwesomeIcons.receipt,color: Colors.white,)),
        ],
      ),
    );
  }
}