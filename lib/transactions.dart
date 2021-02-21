import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'CustomShape/multi_shaper.dart';
import 'package:google_fonts/google_fonts.dart';

class Transactions extends StatefulWidget {
  Transactions({Key key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final search = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                painter: MulltiPainter(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: TextField(
                        controller: search,
                        decoration: InputDecoration(
                            hintText: "Cari di sini",
                            suffixIcon: InkWell(onTap: (){},child: Icon(FontAwesomeIcons.search,size: 20,)),
                            contentPadding: EdgeInsets.all(16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.transparent)
                            ),
                            hintStyle: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.italic,fontSize: 18),
                        ),
                        style: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.italic,fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 26,),
                  Container(
                    padding: EdgeInsets.only(left: 18,right:18,top: 11,bottom: 11),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Pembelian",style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic,fontWeight: FontWeight.w400),),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("45.000.000",style: GoogleFonts.robotoMono(textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,fontStyle: FontStyle.italic)),),
                            Text(" IDR",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(padding: EdgeInsets.all(0.0),itemCount: 3,itemBuilder: (context,index)=>Container(
                      color: Color.fromRGBO(244, 238, 238, 1),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(color: Color.fromRGBO(244, 238, 238, 1),padding: EdgeInsets.all(4.0), child: Text("Senin, 1 Feb 2020",style: TextStyle(color: Color.fromRGBO(131, 131, 131, 1),fontWeight: FontWeight.w700,fontSize: 12),)),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: Container(
                                padding: EdgeInsets.all(4.0),
                              color: Colors.white,
                              child:Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(("PT. Yamaha Central Palembang").length>23?"PT. Yamaha Central Pal..":"PT. Yamaha Central Palembang",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w200),)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("NMAX Honda",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 18),),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("15.000.000",style: GoogleFonts.robotoMono(textStyle: TextStyle(fontWeight: FontWeight.w100,fontSize: 18,fontStyle: FontStyle.italic)),),
                                          Text(" IDR",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 18),),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("debit-card",style: TextStyle(fontWeight: FontWeight.w200,fontSize: 14),),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(FontAwesomeIcons.angleDoubleUp,size: 17,color: Color.fromRGBO(34, 168, 56, 1),),
                                          Text("1500",style: GoogleFonts.robotoMono(textStyle: TextStyle(fontWeight: FontWeight.w100,fontSize: 18,fontStyle: FontStyle.italic)),),
                                          SizedBox(width: 2,),
                                          Icon(FontAwesomeIcons.coins,size: 17,color: Colors.amber,),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ),
                          ), // Loop pakek map agek ini
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: Container(
                                padding: EdgeInsets.all(4.0),
                                color: Colors.white,
                                child:Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(("PT. Yamaha Central Palembang").length>23?"PT. Yamaha Central Pal..":"PT. Yamaha Central Palembang",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w200),)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("NMAX Honda",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 18),),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("15.000.000",style: GoogleFonts.robotoMono(textStyle: TextStyle(fontWeight: FontWeight.w100,fontSize: 18,fontStyle: FontStyle.italic)),),
                                            Text(" IDR",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 18),),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("debit-card",style: TextStyle(fontWeight: FontWeight.w200,fontSize: 14),),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(FontAwesomeIcons.angleDoubleUp,size: 17,color: Color.fromRGBO(34, 168, 56, 1),),
                                            Text("1500",style: GoogleFonts.robotoMono(textStyle: TextStyle(fontWeight: FontWeight.w100,fontSize: 18,fontStyle: FontStyle.italic)),),
                                            SizedBox(width: 2,),
                                            Icon(FontAwesomeIcons.coins,size: 17,color: Colors.amber,),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ],
                      )
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}