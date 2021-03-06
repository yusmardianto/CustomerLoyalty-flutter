import '../CustomShape/voucher_shape.dart';
import '../main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../DataType/voucher.dart';
import '../api/vouchers.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({this.builder}) : super();

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return new FadeTransition(
        opacity: new CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  // TODO: implement barrierLabel
  String get barrierLabel => null;
}

class VoucherDialog {
  // showDialog(Voucher voucher,context){
  //   List<Widget> details = [];
  //   var voucherDetails = voucher.toJsonDisplay();
  //   voucherDetails.keys.forEach((element) {
  //     if(voucherDetails[element]!=null){
  //       details.add(Container(
  //         alignment: Alignment.centerLeft,
  //         padding: EdgeInsets.only(left: 33,right: 33,bottom: 33,top: 33),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Expanded(flex: 1,child: Text('$element')),
  //             Expanded(child: (voucherDetails[element] is String)?HtmlWidget(utils.htmlEscape(voucherDetails[element]??''),)
  //                 :Text("\t${utils.thousandSeperator(voucherDetails[element])??'-'}")),
  //           ],
  //         ),
  //       ));
  //       if(voucherDetails.keys.last!=element)details.add(Divider());
  //     }
  //
  //   });
  //
  //   return Navigator.push(
  //       context, new HeroDialogRoute(
  //     builder: (BuildContext context) {
  //       final _scrollController = ScrollController(initialScrollOffset: 0);
  //       return new Dialog(
  //         backgroundColor: Colors.transparent,
  //         insetPadding: EdgeInsets.all(10),
  //         child: Container(
  //           height: MediaQuery.of(context).size.height*0.7,
  //           child: Stack(
  //             children: [
  //               Positioned.fill(
  //                 child: SingleChildScrollView(
  //                   child: Column(
  //                     children: [
  //                       Container(
  //                         height: 135,
  //                       ),
  //                       Container(
  //                         decoration: BoxDecoration(
  //                             color: Colors.white,
  //                             borderRadius: BorderRadius.circular(20)
  //                         ),
  //                         padding: EdgeInsets.only(top: 10),
  //                         child: Container(
  //                           height: MediaQuery.of(context).size.height*0.4,
  //                           child: Column(
  //                             children: [
  //                               Flexible(
  //                                 flex:7,
  //                                 child: CupertinoScrollbar(
  //                                   controller: _scrollController,
  //                                   isAlwaysShown: true,
  //                                   child: ListView(
  //                                     children: details,
  //                                   ),
  //                                 ),
  //                               ),
  //                               Flexible(
  //                                 flex: 1,
  //                                 child: TextButton(
  //                                   child:Row(
  //                                     crossAxisAlignment: CrossAxisAlignment.center,
  //                                     mainAxisSize: MainAxisSize.min,
  //                                     children: [
  //                                       Text("Klaim"),
  //                                       Text("(${utils.thousandSeperator(voucher.COST_IN_POINT)??''}",style: GoogleFonts.robotoMono(),),
  //                                       Icon(FontAwesomeIcons.coins,color: Colors.amber,),
  //                                       Text(")",style: GoogleFonts.robotoMono(),),
  //                                     ],
  //                                   ),
  //                                   onPressed:()async{
  //                                     Future future = Vouchers().redeem(voucher.LOYALTY_CAMPAIGN_ID);
  //                                     var res = await utils.showLoadingFuture(context,future);
  //                                     utils.toast(res["DATA"],type:(res["STATUS"])?"REGULAR":"ERROR");
  //                                     Navigator.pop(context,true);
  //                                   },),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               Positioned.fill(
  //                 child: new Hero(
  //                   tag: "details",
  //                   child: Stack(
  //                     children: [
  //                       Container(
  //                         height: 152,
  //                         width: MediaQuery.of(context).size.width,
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(20),
  //                             color: Colors.white,
  //                             boxShadow: [
  //                               BoxShadow(
  //                                 color: Colors.grey,
  //                                 spreadRadius: 0.1,
  //                                 offset: Offset(0,2),
  //                                 blurRadius: 2,
  //                               )
  //                             ]
  //                         ),
  //                         child: CustomPaint(
  //                           painter: VoucherPainter(voucher.CAMPAIGN_TYPE),
  //                         ),
  //                       ),
  //                       Container(
  //                         padding: EdgeInsets.all(15),
  //                         height: 152,
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Column(
  //                               mainAxisAlignment: MainAxisAlignment.start,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Text("VOUCHERS",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 34, fontStyle: FontStyle.normal),),),
  //                                 Text(voucher.CAMPAIGN_TYPE??"-",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Colors.amber,fontWeight: FontWeight.w700,fontSize: 20, fontStyle: FontStyle.normal),),),
  //                               ],
  //                             ),
  //                             Column(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               crossAxisAlignment: CrossAxisAlignment.end,
  //                               children: [
  //                                 Text("POTONGAN",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Color.fromRGBO(57,153,184,1),fontWeight: FontWeight.w700,fontSize: 20, fontStyle: FontStyle.normal),),),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(top:15.0,bottom: 15.0),
  //                                   child: Row(
  //                                     children: [
  //                                       Text("${utils.thousandSeperator(voucher.REWARD_VALUE)??'-'}",style: GoogleFonts.robotoMono(textStyle: TextStyle(color: Color.fromRGBO(14,60,74,1),fontWeight: FontWeight.w700,fontSize: 20, fontStyle: FontStyle.normal),),),
  //                                       Container(
  //                                         padding: EdgeInsets.only(left: 5),
  //                                         child: Icon(FontAwesomeIcons.coins,size: 18,color:Colors.amberAccent),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 Text(voucher.NAME,style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Color.fromRGBO(57,153,184,1),fontWeight: FontWeight.w700,fontSize: 16, fontStyle: FontStyle.normal),),),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   ));
  // }
  showVoucherDetails(Voucher voucher, context, {rewardId = null}) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Scaffold(
              bottomNavigationBar: BottomAppBar(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: (rewardId != null)
                      ? TextButton(
                          child: Text(
                            "Gunakan Voucher",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(358, 58)),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(16, 1, 52, 1)),
                          ),
                          onPressed: () async {
                            bool genBarcode = await showDialog(
                                context: context,
                                builder: (context) => SimpleDialog(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.gifts,
                                          size: 60,
                                        ),
                                        SizedBox(height: 15),
                                        Center(
                                            child: Text(
                                          "Gunakan Voucher ini ?",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        )),
                                        SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FlatButton(
                                                minWidth: 120,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    side: BorderSide(
                                                        color: Color.fromRGBO(
                                                            64, 64, 222, 1))),
                                                padding: EdgeInsets.all(10),
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, false);
                                                },
                                                child: Text(
                                                  "Batal",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                            SizedBox(width: 15),
                                            FlatButton(
                                                minWidth: 120,
                                                color: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0)),
                                                padding: EdgeInsets.all(10),
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, true);
                                                },
                                                child: Text(
                                                  "Gunakan",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ],
                                        ),
                                      ],
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          side: BorderSide(
                                              color: Colors.transparent)),
                                      contentPadding: EdgeInsets.all(20),
                                    ));

                            if (genBarcode ?? false) {
                              Future future = Vouchers().useVoucher(rewardId);
                              var res = await utils.showLoadingFuture(
                                  context, future);
                              if (res["STATUS"]) {
                                await utils.genBarcode(
                                    context,
                                    res["DATA"]["transaction_code"],
                                    res["DATA"]["expired"]);
                                // await Users().refreshUser(globVar.user.CUST_ID, globVar.auth.corp);
                                // setState(() {
                                //
                                // });
                              } else {
                                //Navigator.pop(context,res["STATUS"]);
                                utils.toast(res["DATA"], type: "ERROR");
                              }
                            }
                          },
                        )
                      : TextButton(
                          onPressed: () async {
                            Future future = Vouchers()
                                .redeem(voucher.LOYALTY_CAMPAIGN_ID);
                            var res = await utils.showLoadingFuture(
                                context, future);
                            utils.toast(res["DATA"],
                                type: (res["STATUS"]) ? "REGULAR" : "ERROR");
                            Navigator.pop(context, res["STATUS"]);
                          },
                          child: Text(
                            "Claim Voucher",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(358, 58)),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(16, 1, 52, 1)),
                          ),
                        ),
                ),
              ),
              body: Container(
                margin: EdgeInsets.only(top: 30),
                child: ConstrainedBox(
                  constraints: new BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.96,
                  ),
                  child: Container(
                    // padding: EdgeInsets.only(left:10,right: 10,top: 15,bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Hero(
                          tag: "details",
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: CustomPaint(
                                    painter: VoucherPainter(
                                        voucher.CAMPAIGN_TYPE,
                                        withRadius: false),
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "VOUCHERS",
                                              style:
                                                  GoogleFonts.robotoCondensed(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 30,
                                                    fontStyle:
                                                        FontStyle.normal),
                                              ),
                                            ),
                                            Text(
                                              voucher.CAMPAIGN_TYPE ?? "-",
                                              style:
                                                  GoogleFonts.robotoCondensed(
                                                textStyle: TextStyle(
                                                    color: Colors.amber,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                    fontStyle:
                                                        FontStyle.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "POTONGAN",
                                              style:
                                                  GoogleFonts.robotoCondensed(
                                                textStyle: TextStyle(
                                                    color: Color.fromRGBO(
                                                        57, 153, 184, 1),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 21,
                                                    fontStyle:
                                                        FontStyle.normal),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0, bottom: 5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "${voucher.REWARD_VALUE ?? '-'}",
                                                    style:
                                                        GoogleFonts.robotoMono(
                                                      textStyle: TextStyle(
                                                          color: Color.fromRGBO(
                                                              14, 60, 74, 1),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 20,
                                                          fontStyle:
                                                              FontStyle.normal),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    child: Icon(
                                                        FontAwesomeIcons.coins,
                                                        size: 26,
                                                        color:
                                                            Colors.amberAccent),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              voucher.NAME,
                                              style:
                                                  GoogleFonts.robotoCondensed(
                                                textStyle: TextStyle(
                                                    color: Color.fromRGBO(
                                                        57, 153, 184, 1),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                    fontStyle:
                                                        FontStyle.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 168 / 3,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                Colors.grey.withOpacity(0.5),
                                                Colors.transparent
                                              ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                  color: Color.fromRGBO(214, 214, 214, 1),
                                ),
                              ),
                              Positioned.fill(
                                  child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 7),
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth:
                                            MediaQuery.of(context).size.width,
                                        minHeight: 134,
                                      ),
                                      child: Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.all(25),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text(
                                                "Voucher ${voucher.NAME}",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        0, 0, 52, 1),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text(
                                                  voucher.CAMPAIGN_TYPE ?? "-"),
                                            ),
                                            Divider(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Berlaku pada"),
                                                Text(voucher.PERIOD ?? ''),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 12,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.all(25),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 12.0),
                                                      child: Text(
                                                        "Syarat dan Ketentuan Voucher",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                    HtmlWidget(
                                                      utils.htmlEscape(voucher
                                                              .CONDITION_DESC ??
                                                          '-'),
                                                    ),
                                                    Divider(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 12.0),
                                                      child: Text(
                                                        "Deskripsi Voucher",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                    HtmlWidget(
                                                      utils.htmlEscape(
                                                          voucher.SHORT_DESC ??
                                                              '-'),
                                                    ),
                                                    Divider(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 12.0),
                                                      child: Text(
                                                        "Cara pakai Voucher",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                    HtmlWidget(
                                                      utils.htmlEscape(
                                                          voucher.HOW_TO_USE ??
                                                              '-'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
