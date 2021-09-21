import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'CustomWidget/bottom_appbar.dart';
import 'main.dart';
import 'api/transactions.dart';
import 'DataType/transaction.dart';
import 'package:intl/intl.dart';

class Transactions extends StatefulWidget {
  Transactions({Key key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final search = new TextEditingController();
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  List<Transaction> transList = [];
  String start_date = DateFormat('dd-MMM-yyyy').format(DateTime(DateTime.now().year,DateTime.now().month,1));
  String end_date = DateFormat('dd-MMM-yyyy').format(DateTime.now());

  void _onRefresh() async{
    print("refreshing");
    await Future.delayed(Duration(milliseconds: 1000));
    await loadTransactions();
    _refreshController.refreshCompleted();
  }

  loadTransactions()async{
    setState(() {
      globVar.isLoading = true;
    });
    var res = await Trans().getList(start_date,end_date);
    if(res["STATUS"]==1){
      transList.clear();
      for(var i = 0;i<res["DATA"].length;i++){
        transList.add(Transaction.fromJson(res["DATA"][i]));
      }
    }
    setState(() {
      globVar.isLoading = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    search.text = '$start_date - $end_date';
    loadTransactions();
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
              //   height: MediaQuery.of(context).size.height,
              //   width: MediaQuery.of(context).size.width,
              //   child: CustomPaint(
              //     painter: WavePainter(),
              //   ),
              // ),
              Container(
                color: Color.fromRGBO(0, 0, 46, 1),
                height: MediaQuery.of(context).size.height*0.43,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: FormBuilderDateRangePicker(
                            controller: search,
                            name: "filter",
                            onChanged: (DateTimeRange value){
                                start_date = DateFormat('dd-MMM-yyyy').format(value.start);
                                end_date = DateFormat('dd-MMM-yyyy').format(value.end);
                                search.text = "${DateFormat("dd-MMM-yyyy").format(value.start)} - ${DateFormat("dd-MMM-yyyy").format(value.end)}";
                                loadTransactions();
                            },
                            firstDate: DateTime(DateTime.now().year,1,1),
                            lastDate: DateTime(DateTime.now().year,12,1),
                            format: DateFormat('dd-MMM-yyyy'),
                            decoration: InputDecoration(
                                suffixIcon: Icon(FontAwesomeIcons.filter,size: 20,),
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
                    ),
                    SizedBox(height: 26,),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned.fill(child: Container(color: Colors.white,)),
                          Positioned.fill(child: Column(
                            children: [
                              Expanded(
                                child: SmartRefresher(
                                  enablePullDown: true,
                                  // header: WaterDropHeader(),
                                  controller: _refreshController,
                                  onRefresh: _onRefresh,
                                  child: (transList.length==0)
                                      ?Center(child: (globVar.isLoading)?CircularProgressIndicator():Text("Data kosong",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black54),))
                                      :ListView.builder(padding: EdgeInsets.all(0.0),itemCount: transList.map((i)=>DateFormat('dd-MMM-yyyy').format(i.TRANSACTION_DATE)).toSet().length,itemBuilder: (context,index)
                                  {
                                    var date = transList.map((i)=>DateFormat('dd-MMM-yyyy').format(i.TRANSACTION_DATE)).toSet().toList();
                                    var transaction = transList.where((i) => DateFormat('dd-MMM-yyyy').format(i.TRANSACTION_DATE)==date[index]);
                                    List<Widget> children = transaction.map((i) => Padding(
                                      padding: const EdgeInsets.only(bottom: 2.0),
                                      child: Container(
                                          padding: EdgeInsets.only(left:11, right:11,top:15,bottom:15),
                                          color: Colors.white,
                                          child:Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text("${i.POS_NAME??'-'}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),)
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("${i.DESCRIPTION??'#'}",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 13),),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      i.POINT_EARN>=0
                                                          ?Icon(FontAwesomeIcons.angleDoubleUp,size: 17,color: Color.fromRGBO(34, 168, 56, 1),)
                                                          :Icon(FontAwesomeIcons.angleDoubleDown,size: 17,color: Colors.redAccent,),
                                                      Text(
                                                        "${utils.thousandSeperator(i.POINT_EARN) ?? 0}",style: GoogleFonts.robotoMono(textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 14,fontStyle: FontStyle.normal)),),
                                                      SizedBox(width: 2,),
                                                      Icon(FontAwesomeIcons.coins,size: 17,color: Colors.amber,),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                      ),
                                    )).toList();
                                    return  Container(
                                        color: Color.fromRGBO(223,223,223,1),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(padding: EdgeInsets.all(4.0), child: Text(date[index],style: TextStyle(color: Color.fromRGBO(117,117,117,1),fontWeight: FontWeight.w700,fontSize: 13,),)),
                                            Column(
                                              children: children,
                                            ), // Loop pakek map agek ini
                                          ],
                                        )
                                    );
                                  }
                                  ),
                                ),
                              ),
                            ],
                          )),
                          // Positioned.fill(child: (transList.length==0)
                          //     ?SmartRefresher(enablePullDown: true,
                          //     header: WaterDropHeader(),
                          //     controller: _refreshController,
                          //     onRefresh: _onRefresh,
                          //     child: Center(child: (globVar.isLoading)?CircularProgressIndicator():Text("Data kosong",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black54),)))
                          //     :Column(
                          //   children: [
                          //     // Container(
                          //     //   padding: EdgeInsets.only(left: 18,right:18,top: 11,bottom: 11),
                          //     //   decoration: BoxDecoration(
                          //     //       color: Colors.white,
                          //     //       borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                          //     //   ),
                          //     //   child: Row(
                          //     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     //     children: [
                          //     //       Text("Total Pembelian",style: TextStyle(fontSize: 18,fontStyle: FontStyle.normal,fontWeight: FontWeight.w400),),
                          //     //       Row(
                          //     //         mainAxisSize: MainAxisSize.min,
                          //     //         children: [
                          //     //           Text("45.000.000",style: GoogleFonts.robotoMono(textStyle: TextStyle(color: Colors.black54,fontSize: 18,fontWeight: FontWeight.w300,fontStyle: FontStyle.normal)),),
                          //     //           Text(" IDR",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal))
                          //     //         ],
                          //     //       ),
                          //     //     ],
                          //     //   ),
                          //     // ),
                          //     Expanded(
                          //       child: SmartRefresher(
                          //         enablePullDown: true,
                          //         header: WaterDropHeader(),
                          //         controller: _refreshController,
                          //         onRefresh: _onRefresh,
                          //         child: ListView.builder(padding: EdgeInsets.all(0.0),itemCount: transList.map((i)=>DateFormat('dd-MMM-yyyy').format(i.TRANSACTION_DATE)).toSet().length,itemBuilder: (context,index)
                          //         {
                          //           var date = transList.map((i)=>DateFormat('dd-MMM-yyyy').format(i.TRANSACTION_DATE)).toSet().toList();
                          //           var transaction = transList.where((i) => DateFormat('dd-MMM-yyyy').format(i.TRANSACTION_DATE)==date[index]);
                          //           List<Widget> children = transaction.map((i) => Padding(
                          //             padding: const EdgeInsets.only(bottom: 2.0),
                          //             child: Container(
                          //                 padding: EdgeInsets.only(left:11, right:11,top:15,bottom:15),
                          //                 color: Colors.white,
                          //                 child:Column(
                          //                   children: [
                          //                     Row(
                          //                       mainAxisAlignment: MainAxisAlignment.start,
                          //                       children: [
                          //                         Text("${i.POS_NAME??'-'}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),)
                          //                       ],
                          //                     ),
                          //                     SizedBox(height: 10,),
                          //                     Row(
                          //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //                       children: [
                          //                         Text("${i.DESCRIPTION??'#'}",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 13),),
                          //                         Row(
                          //                           mainAxisSize: MainAxisSize.min,
                          //                           children: [
                          //                             i.POINT_EARN>=0
                          //                                 ?Icon(FontAwesomeIcons.angleDoubleUp,size: 17,color: Color.fromRGBO(34, 168, 56, 1),)
                          //                                 :Icon(FontAwesomeIcons.angleDoubleDown,size: 17,color: Colors.redAccent,),
                          //                             Text(
                          //                                "${utils.thousandSeperator(i.POINT_EARN) ?? 0}",style: GoogleFonts.robotoMono(textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 14,fontStyle: FontStyle.normal)),),
                          //                             SizedBox(width: 2,),
                          //                             Icon(FontAwesomeIcons.coins,size: 17,color: Colors.amber,),
                          //                           ],
                          //                         )
                          //                       ],
                          //                     ),
                          //                   ],
                          //                 )
                          //             ),
                          //           )).toList();
                          //           return  Container(
                          //               color: Color.fromRGBO(223,223,223,1),
                          //               child:Column(
                          //                 crossAxisAlignment: CrossAxisAlignment.start,
                          //                 children: [
                          //                   Container(padding: EdgeInsets.all(4.0), child: Text(date[index],style: TextStyle(color: Color.fromRGBO(117,117,117,1),fontWeight: FontWeight.w700,fontSize: 13,),)),
                          //                   Column(
                          //                     children: children,
                          //                   ), // Loop pakek map agek ini
                          //                 ],
                          //               )
                          //           );
                          //         }
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ))
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
      bottomNavigationBar:
      BottomAppbar(_onRefresh, 2),
    );
  }
}