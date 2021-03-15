import 'package:customer_loyalty/CustomShape/voucher_shape.dart';
import 'package:customer_loyalty/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../DataType/voucher.dart';
import '../api/vouchers.dart';

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({ this.builder }) : super();

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
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return new FadeTransition(
        opacity: new CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut
        ),
        child: child
    );
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
class VoucherDialog{
  showDialog(Voucher voucher,context){
    List<Widget> details = [];
    var voucherDetails = voucher.toJsonDisplay();
    voucherDetails.keys.forEach((element) {
      if(voucherDetails[element]!=null){
        details.add(Container(
          padding: EdgeInsets.only(left: 33,right: 33,bottom: 33,top: 33),
          child: Row(
            children: [
              Text('$element \t:\t'),
              Text("\t${voucherDetails[element]??'-'}"),
            ],
          ),
        ));
        if(voucherDetails.keys.last!=element)details.add(Divider());
      }

    });

    Navigator.push(
        context, new HeroDialogRoute(
      builder: (BuildContext context) {
        final _scrollController = ScrollController();
        return new Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          child: Container(
            height: MediaQuery.of(context).size.height*0.7,
            child: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 135,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          padding: EdgeInsets.only(top: 10),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.4,
                            child: Column(
                              children: [
                                Flexible(
                                  flex:7,
                                  child: CupertinoScrollbar(
                                    controller: _scrollController,
                                    isAlwaysShown: true,
                                    child: ListView(
                                      children: details,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: TextButton(
                                    child:Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("Klaim"),
                                        Text("(${voucher.COST_IN_POINT??''}",style: GoogleFonts.robotoMono(),),
                                        Icon(FontAwesomeIcons.coins,color: Colors.amber,),
                                        Text(")",style: GoogleFonts.robotoMono(),),
                                      ],
                                    ),
                                    onPressed:()async{
                                      Future future = Vouchers().redeem(voucher.LOYALTY_CAMPAIGN_ID);
                                      var res = await utils.showLoadingFuture(context,future);
                                      utils.toast(res["DATA"],type:(res["STATUS"])?"REGULAR":"ERROR");
                                    },),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: new Hero(
                    tag: "details",
                    child: Stack(
                      children: [
                        Container(
                          height: 152,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 0.1,
                                  offset: Offset(0,2),
                                  blurRadius: 2,
                                )
                              ]
                          ),
                          child: CustomPaint(
                            painter: VoucherPainter(voucher.CAMPAIGN_TYPE),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          height: 152,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("VOUCHERS",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 34, fontStyle: FontStyle.italic),),),
                                  Text(voucher.CAMPAIGN_TYPE??"-",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Colors.amber,fontWeight: FontWeight.w700,fontSize: 20, fontStyle: FontStyle.italic),),),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("POTONGAN",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Color.fromRGBO(57,153,184,1),fontWeight: FontWeight.w700,fontSize: 20, fontStyle: FontStyle.italic),),),
                                  Padding(
                                    padding: const EdgeInsets.only(top:15.0,bottom: 15.0),
                                    child: Row(
                                      children: [
                                        Text("${voucher.REWARD_VALUE??'-'}",style: GoogleFonts.robotoMono(textStyle: TextStyle(color: Color.fromRGBO(14,60,74,1),fontWeight: FontWeight.w700,fontSize: 20, fontStyle: FontStyle.italic),),),
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Icon(FontAwesomeIcons.coins,size: 18,color:Colors.amberAccent),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(voucher.NAME,style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Color.fromRGBO(57,153,184,1),fontWeight: FontWeight.w700,fontSize: 16, fontStyle: FontStyle.italic),),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}