import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'CustomShape/voucher_shape.dart';
import 'CustomWidget/bottom_appbar.dart';
import 'api/users.dart';
import 'main.dart';
import 'DataType/voucher.dart';
import 'api/vouchers.dart';
import 'CustomWidget/voucher_detail.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class VouchersList extends StatefulWidget {
  bool checkMyVoucher;
  VouchersList({this.checkMyVoucher=false});

  @override
  _VouchersListState createState() => _VouchersListState();
}

class _VouchersListState extends State<VouchersList>  with SingleTickerProviderStateMixin{
  final search = new TextEditingController();
  List<Voucher> voucherList = [];
  TabController _controller;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    print("refreshing");
    try{
      await Future.delayed(Duration(milliseconds: 1000));
      loadAvailableVoucher();
      loadMyVoucher();
      _refreshController.refreshCompleted();
    }
    catch(e){
      setState(() {
        globVar.isLoading = false;
      });
      _refreshController.refreshCompleted();
    }

  }

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
    try{
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
      await Users().refreshUser(globVar.user.CUST_ID, globVar.auth.corp);
      setState(() {
        globVar.isLoading = false;
      });
    }
    catch(e){
      print("error $e");
    }
    // if(widget.checkMyVoucher??false)showMyVoucher();
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
                child:
                TextField(
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
    if(globVar.user!=null){
      loadAvailableVoucher();
      loadMyVoucher();
    }
    _controller = TabController(length: 2, vsync: this,initialIndex: widget.checkMyVoucher?1:0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: ()async{
          Navigator.of(context).popUntil((route) => route.settings.name == '/home' || route.settings.name == '/');
          return false;
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Stack(
            children: [
              // Container(
              //   color: Color.fromRGBO(0, 0, 46, 1),
              //   height: MediaQuery.of(context).size.height*0.18,
              //   width: MediaQuery.of(context).size.width,
              // ),
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
                    Center(
                      child: Container(
                        width: 335,
                        height:178,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/voucher_list.png"),
                            fit: BoxFit.fitWidth
                          )
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15,bottom:20),
                      alignment: Alignment.centerLeft,
                      // decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(15)
                      // ),
                      child: Text('List Voucher',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w700,color: Color.fromRGBO(0, 0, 52, 1)),)
                      // TextField(
                      //   controller: search,
                      //   decoration: InputDecoration(
                      //     hintText: "Cari di sini",
                      //     suffixIcon: InkWell(onTap: (){},child: Icon(FontAwesomeIcons.search,size: 20,)),
                      //     contentPadding: EdgeInsets.all(16.0),
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(15),
                      //         borderSide: BorderSide(color: Colors.transparent)
                      //     ),
                      //     hintStyle: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.normal,fontSize: 18),
                      //   ),
                      //   style: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.normal,fontSize: 18),
                      // ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Points',style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontSize: 15,fontWeight: FontWeight.w500),),
                              Text('Point Reward yang Tersedia',style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontSize: 15,fontWeight: FontWeight.w400),),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                            child: Container(
                              alignment: Alignment.center,
                             decoration: BoxDecoration(
                               color: Color.fromRGBO(0, 0, 52, 1),
                               borderRadius: BorderRadius.circular(15)
                             ),
                                height: 38,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${utils.thousandSeperator(globVar.user==null?0:globVar.user.CUST_POINT??0)}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w400),),
                                SizedBox(width: 10,),
                                Icon(FontAwesomeIcons.coins,size: 18,color:Colors.amberAccent),
                              ],
                            )))
                      ],
                    ),
                    TabBar(
                        labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Color.fromRGBO(0, 0, 52, 1)),
                      // unselectedLabelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color.fromRGBO(0, 0, 52, 1)),
                      labelColor: Color.fromRGBO(0, 0, 52, 1),
                      controller: _controller,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Color.fromRGBO(0, 0, 52, 1),
                      tabs: [
                        Tab(
                          text: "Tersedia",
                        ),
                        Tab(
                          text: "Voucher Saya",
                        ),
                      ]
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _controller,
                        children: [
                          (globVar.isLoading)?ListView.builder(
                            itemCount: 6,
                            itemBuilder: (context,index)=>Padding(
                              padding: EdgeInsets.only(top:15),
                              child: Container(
                                height: 96,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(237, 237, 237, 1)
                                ),
                              ),
                            ),
                          )
                              :SmartRefresher(
                                controller: _refreshController,
                                onRefresh: _onRefresh,
                                child: ListView.builder(
                            itemCount: voucherList.length,
                            itemBuilder: (context,index)=>InkWell(
                                onTap: ()async{
                                  var refresh = await VoucherDialog().showVoucherDetails(voucherList[index], context);
                                  // var refresh = await showVoucherDetails(voucherList[index]);
                                  if(refresh??false) _onRefresh();
                                },
                                child: Hero(
                                  tag: "details",
                                  child: Padding(
                                    padding: EdgeInsets.only(top:15),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 96,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(color: Colors.grey),
                                            color: Colors.white,
                                          ),
                                          child: CustomPaint(
                                            painter: VoucherPainter(voucherList[index].CAMPAIGN_TYPE),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("VOUCHERS",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20, fontStyle: FontStyle.normal),),),
                                                  Text(voucherList[index].CAMPAIGN_TYPE??"-",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Colors.amber,fontWeight: FontWeight.w700,fontSize: 16, fontStyle: FontStyle.normal),),),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text("POTONGAN",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Color.fromRGBO(57,153,184,1),fontWeight: FontWeight.w700,fontSize: 16, fontStyle: FontStyle.normal),),),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
                                                    child: Row(
                                                      children: [
                                                        Text("${voucherList[index].REWARD_VALUE??'-'}",style: GoogleFonts.robotoMono(textStyle: TextStyle(color: Color.fromRGBO(14,60,74,1),fontWeight: FontWeight.w700,fontSize: 16, fontStyle: FontStyle.normal),),),
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
                          (globVar.isLoading)?ListView.builder(
                            itemCount: 6,
                            itemBuilder: (context,index)=>Padding(
                              padding: EdgeInsets.only(top:15),
                              child: Container(
                                height: 96,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(237, 237, 237, 1)
                                ),
                              ),
                            ),
                          )
                              :SmartRefresher(
                                controller: _refreshController,
                                onRefresh: _onRefresh,
                                child: ListView.builder(
                            itemCount: globVar.myVouchers.length,
                            itemBuilder: (context,index)=>InkWell(
                                onTap: ()async{
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
                                    Future future = Vouchers().useVoucher(globVar.myVouchers[index].LOYALTY_CUST_REWARD_ID);
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
                                        height: 96,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.grey),
                                          color: Colors.white,
                                        ),
                                        child: CustomPaint(
                                          painter: VoucherPainter("My Voucher"),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("VOUCHERS",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20, fontStyle: FontStyle.normal),),),
                                                Text(globVar.myVouchers[index].COUPON??"-",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Colors.amber,fontWeight: FontWeight.w700,fontSize: 16, fontStyle: FontStyle.normal),),),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text("POTONGAN",style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Color.fromRGBO(57,153,184,1),fontWeight: FontWeight.w700,fontSize: 16, fontStyle: FontStyle.normal),),),
                                                Padding(
                                                  padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
                                                  child: Row(
                                                    children: [
                                                      Text("${globVar.myVouchers[index].REWARD_VALUE??'-'}",style: GoogleFonts.robotoMono(textStyle: TextStyle(color: Color.fromRGBO(14,60,74,1),fontWeight: FontWeight.w700,fontSize: 16, fontStyle: FontStyle.normal),),),
                                                      Container(
                                                        padding: EdgeInsets.only(left: 5),
                                                        child: Icon(FontAwesomeIcons.coins,size: 18,color:Colors.amberAccent),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Text(globVar.myVouchers[index].COUPON,style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Color.fromRGBO(57,153,184,1),fontWeight: FontWeight.w700,fontSize: 16, fontStyle: FontStyle.normal),),),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:BottomAppbar(_onRefresh, 3),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: (){
      //     showMyVoucher();
      //   },
      //     isExtended: true,
      //     label: const Text('My Voucher'),
      //     backgroundColor: Color.fromRGBO(207,79,79,1),
      //     icon: Icon(FontAwesomeIcons.shoppingBag),
      // ),
    );
  }
}