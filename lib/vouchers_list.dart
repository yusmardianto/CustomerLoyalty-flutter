import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'CustomShape/multi_shaper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'CustomShape/voucher_shape.dart';
import 'api/users.dart';
import 'main.dart';
import 'DataType/voucher.dart';
import 'api/vouchers.dart';
import 'CustomWidget/voucher_detail.dart';

class VouchersList extends StatefulWidget {
  // VouchersList({Key key}) : super(key: key);
  bool checkMyVoucher;
  VouchersList({this.checkMyVoucher=false});

  @override
  _VouchersListState createState() => _VouchersListState();
}

class _VouchersListState extends State<VouchersList> {
  final search = new TextEditingController();
  List<Voucher> voucherList = [];


  loadAvailableVoucher()async {
    setState(() {
      globVar.isLoading = true;
    });
    var res = await Vouchers().getAvailableList();
    if(res["STATUS"]==1){
      voucherList.clear();
      for(var i = 0;i<res["DATA"].length;i++){
        voucherList.add(Voucher.fromJson(res["DATA"][i]));
      }
    }
    setState(() {
      globVar.isLoading = false;
    });
  }
  loadMyVoucher()async{
    setState(() {
      globVar.isLoading = true;
    });
    var res = await Vouchers().getMyVoucherList();
    if(res["STATUS"]==1){
      List<MyVoucher> myVoucherList = [];
      for(var i = 0;i<res["DATA"].length;i++){
        myVoucherList.add(MyVoucher.fromJson(res["DATA"][i]));
      }
      globVar.myVouchers = myVoucherList;
    }
    setState(() {
      globVar.isLoading = false;
    });
    if(widget.checkMyVoucher??false)showMyVoucher();
  }

  showMyVoucher(){
    List<Widget> myVoucher = [];
    myVoucher.addAll(globVar.myVouchers.map((e) => InkWell(
      onTap: ()async {
        // showDialog(
        //     context: context,
        //     builder:(context)=>AlertDialog(
        //       content: Text("Gunakan Voucher ini ?"),
        //       actions: [
        //         TextButton(
        //           onPressed: (){
        //             Navigator.pop(context);
        //           },
        //           child: Text("Batal"),
        //         ),
        //         TextButton(
        //           onPressed: (){
        //             Navigator.pop(context);
        //           },
        //           child: Text("Gunakan"),
        //         ),
        //       ],
        //     )
        // );

        bool genBarcode = await showDialog(
            context: context,
            builder: (context)=>SimpleDialog(
              children: [
                Icon(FontAwesomeIcons.gifts,size: 60,),
                SizedBox(height: 15),
                Center(child: Text("Gunakan Voucher ini ?",style: TextStyle(fontStyle: FontStyle.normal,fontSize: 16,fontWeight: FontWeight.w400),)),
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
                        child: Text("Batal",style: TextStyle(fontStyle: FontStyle.normal,fontSize: 18,fontWeight: FontWeight.w500),)
                    ),
                    SizedBox(width: 15),
                    FlatButton(
                        minWidth: 120,
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        padding: EdgeInsets.all(10),
                        onPressed: (){
                          Navigator.pop(context,true);
                        },
                        child: Text("Gunakan",style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal,fontSize: 18,fontWeight: FontWeight.w500),)
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

        if(genBarcode??false){
          Future future = Vouchers().useVoucher(e.LOYALTY_CUST_REWARD_ID);
          var res = await utils.showLoadingFuture(context,future);
          if(res["STATUS"]){
            print(res["DATA"]);
            await utils.genBarcode(context,res["DATA"]["transaction_code"],res["DATA"]["expired"]);
            // await Users().refreshUser(globVar.user.CUST_ID, globVar.auth.corp);
            setState(() {

            });
          }
          else{
            utils.toast(res["DATA"],type: "ERROR");
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.only(top:15),
        child: Stack(
          children: [
            Container(
              height: 152,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey,width: 0.1),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1,
                        spreadRadius: 0.1,
                        offset: Offset(0,3)
                    )
                  ]
              ),
              child: CustomPaint(
                painter: VoucherPainter(e.DESCRIPTION),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              height: 152,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("VOUCHERS",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 34, fontStyle: FontStyle.normal),),),
                          Text(e.COUPON??"-",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Colors.amber,fontWeight: FontWeight.w700,fontSize: 20, fontStyle: FontStyle.normal),),),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("POTONGAN",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Color.fromRGBO(57,153,184,1),fontWeight: FontWeight.w700,fontSize: 20, fontStyle: FontStyle.normal),),),
                          Padding(
                            padding: const EdgeInsets.only(top:15.0,bottom: 15.0),
                            child: Row(
                              children: [
                                Text("${e.REWARD_VALUE??'-'}",style: GoogleFonts.robotoMono(textStyle: TextStyle(color: Color.fromRGBO(14,60,74,1),fontWeight: FontWeight.w700,fontSize: 20, fontStyle: FontStyle.normal),),),
                                Container(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(FontAwesomeIcons.coins,size: 18,color:Colors.amberAccent),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(e.PERIOD,style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Color.fromRGBO(57,153,184,1),fontWeight: FontWeight.w700,fontSize: 16, fontStyle: FontStyle.normal),),),
                ],
              ),
            ),
          ],
        ),
      ),
    )));
    showModalBottomSheet(context: context, isScrollControlled: true, builder: (context){
      return ConstrainedBox(
        constraints: new BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height*0.7,
        ),
        child: Container(
          padding: EdgeInsets.only(left:10,right: 10,top: 15,bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                    hintStyle: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.normal,fontSize: 18),
                  ),
                  style: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.normal,fontSize: 18),
                ),
              ),
              (globVar.myVouchers.length==0)?Container(height: 250,child: Center(child: Text("Kamu belum punya voucher",style: TextStyle(color: Colors.grey),),),):Flexible(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: myVoucher,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    loadAvailableVoucher();
    loadMyVoucher();
    super.initState();
  }
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
              color: Color.fromRGBO(0, 0, 46, 1),
              height: MediaQuery.of(context).size.height*0.18,
              width: MediaQuery.of(context).size.width,
            ),
            // Container(
            //   height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
              // child: CustomPaint(
              //   painter: MulltiPainter(),
              // ),
            // ),
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
                        hintStyle: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.normal,fontSize: 18),
                      ),
                      style: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.normal,fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: (globVar.isLoading)?ListView.builder(
                      itemCount: 6,
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
                    )
                    :ListView.builder(
                      itemCount: voucherList.length,
                      itemBuilder: (context,index)=>InkWell(
                        onTap: ()async{
                          var refresh = await VoucherDialog().showDialog(voucherList[index], context);
                          if(refresh??false) await loadMyVoucher();
                        },
                        child: Hero(
                          tag: "details",
                          child: Padding(
                            padding: EdgeInsets.only(top:15),
                            child: Stack(
                              children: [
                                Container(
                                  height: 152,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: CustomPaint(
                                    painter: VoucherPainter(voucherList[index].CAMPAIGN_TYPE),
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
                                          Text("VOUCHERS",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 34, fontStyle: FontStyle.normal),),),
                                          Text(voucherList[index].CAMPAIGN_TYPE??"-",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Colors.amber,fontWeight: FontWeight.w700,fontSize: 20, fontStyle: FontStyle.normal),),),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("POTONGAN",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Color.fromRGBO(57,153,184,1),fontWeight: FontWeight.w700,fontSize: 20, fontStyle: FontStyle.normal),),),
                                          Padding(
                                            padding: const EdgeInsets.only(top:15.0,bottom: 15.0),
                                            child: Row(
                                              children: [
                                                Text("${voucherList[index].REWARD_VALUE??'-'}",style: GoogleFonts.robotoMono(textStyle: TextStyle(color: Color.fromRGBO(14,60,74,1),fontWeight: FontWeight.w700,fontSize: 20, fontStyle: FontStyle.normal),),),
                                                Container(
                                                  padding: EdgeInsets.only(left: 5),
                                                  child: Icon(FontAwesomeIcons.coins,size: 18,color:Colors.amberAccent),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(voucherList[index].NAME,style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Color.fromRGBO(57,153,184,1),fontWeight: FontWeight.w700,fontSize: 16, fontStyle: FontStyle.normal),),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
      BottomAppBar(
          child: Container(
            height: 63,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap:  ()async{
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(Icons.home,size: 26,),
                    ),
                  ),
                  Container(color: Colors.grey.withOpacity(0.2), width: 1,),
                  InkWell(
                    onTap: ()async{
                      await Navigator.pushNamed(context, "/transactions");

                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(FontAwesomeIcons.receipt,size:26),
                    ),
                  ),
                  Container(color: Colors.grey.withOpacity(0.2), width: 1,),
                  InkWell(
                    onTap: loadAvailableVoucher,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(FontAwesomeIcons.gift,size:26),
                    ),
                  ),
                  Container(color: Colors.grey.withOpacity(0.2), width: 1,),
                  InkWell(
                    onTap: () async {
                      await Navigator.pushNamed(context, "/profile");

                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(FontAwesomeIcons.addressCard,size:24),
                    ),
                  ),
                ]
            ),
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showMyVoucher();
        },
          isExtended: true,
          label: const Text('My Voucher'),
          backgroundColor: Color.fromRGBO(0, 0, 46, 1),//Color.fromRGBO(207,79,79,1),
          icon: Icon(FontAwesomeIcons.shoppingBag),
      ),
    );
  }
}