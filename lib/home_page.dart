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
                            child: Text("Beranda",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 24),),
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
                            child: Text("Vouchers saya :",style: TextStyle(shadows: [
                              Shadow(
                                offset: Offset(3.0, 3.0),
                                blurRadius: 0.5,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ],color: Colors.white,fontStyle: FontStyle.italic,fontWeight: FontWeight.w500,fontSize: 18),),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 15),
                            child: Text("Semua",style: TextStyle(
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
                            child: Text("Product dalam diskon :",style: TextStyle(shadows: [
                              Shadow(
                                offset: Offset(3.0, 3.0),
                                blurRadius: 0.5,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ],color: Colors.white,fontStyle: FontStyle.italic,fontWeight: FontWeight.w500,fontSize: 18),),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 15),
                            child: Text("Semua",style: TextStyle(
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
        onTap: (idx)async{
          switch(idx){
            case 0 : {
              await showDialog(
                  context: context,
                  builder: (context)=>SimpleDialog(
                children: [
                  Icon(Icons.support_agent,size: 85,),
                  Center(child: Text("Butuh bantuan dalam menggunakan aplikasi? \n Silakan hubungi team support kami lewat : ",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 13,fontWeight: FontWeight.w300),)),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Color.fromRGBO(64, 64, 222, 1), style: BorderStyle.solid, width: 0.80),
                    ),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none
                      ),
                      isExpanded: true,
                      onChanged: (value){},
                      items: [
                        DropdownMenuItem(child: Text("WhatsApp"),value: "WA",)
                      ],
                    ),
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
            }break;
            case 1 : {
              Navigator.pushNamed(context, "/profile");
            }break;
            case 2 : {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => Container(
                    // padding: EdgeInsets.all(22),
                    height: MediaQuery.of(context).size.height*0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            SizedBox(height: 20,),
                            Container(padding: EdgeInsets.all(22),child: Text("Apa yang mau dilakukan hari ini ?",style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic,fontWeight: FontWeight.w200,color: Colors.black),)),
                          Container(
                            height: 104.0*2,
                            child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(top: 22,right: 10,left: 10),
                                itemCount: 8,
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                                itemBuilder: (context,indx)=>Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 74,
                                    width: 74,
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
                  )
              );
            }break;
            case 3 : {

            }break;
            case 4 : {
              Navigator.pushNamed(context, "/transactions");
            }break;
          }
        },
        items: [
          BottomNavigationBarItem(title: Container(),icon: Icon(FontAwesomeIcons.headset,color: Colors.white,)),
          BottomNavigationBarItem(title: Container(),icon: Icon(FontAwesomeIcons.addressCard,color: Colors.white,)),
          BottomNavigationBarItem(title: Container(),icon: Icon(Icons.widgets_outlined,color: Colors.white,)),
          BottomNavigationBarItem(title: Container(),icon: Icon(FontAwesomeIcons.gift,color: Colors.white,)),
          BottomNavigationBarItem(title: Container(),icon: Icon(FontAwesomeIcons.receipt,color: Colors.white,)),
        ],
      ),
    );
  }
}