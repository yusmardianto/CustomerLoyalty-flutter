import 'package:flutter/material.dart';
import 'CustomShape/circle_tab_indicator.dart';
import 'DataType/contents.dart';
import 'api/contents.dart';
import 'main.dart';

class FirstPage extends StatefulWidget {

  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with SingleTickerProviderStateMixin {
  TabController _controller;
  List<Content> featureList = [];

  init() async {
    try{
      var res = await ContentApi().getContents("FEATURES");
      if (res["STATUS"] == 1) {
        featureList.clear();
        for (var i = 0; i < res["DATA"].length; i++) {
          featureList.add(Content.fromJson(res["DATA"][i]));
        }
      } else {
        throw ('Error fetching features!');
      }
    }catch(e){
      print("error $e");
    }
    setState(() {
      _controller = TabController(length: featureList.length, vsync: this);
    });
  }
  
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(featureList.length==0) Navigator.pushReplacementNamed(context,'/login');
    else{
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
                                children: featureList.map((i) => Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(196, 196, 196, 1),
                                      shape: BoxShape.circle
                                  ),
                                )
                                ).toList(),
                              ),
                            ),
                            TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              controller: _controller,
                              indicator: CircleTabIndicator(color: Color.fromRGBO(0, 0, 52, 1), radius: 6),
                              tabs: featureList.map((i)=>Container(
                                width: 13,
                                height: 13,
                              )).toList(),
                              // tabs: [
                              //   Container(
                              //     width: 13,
                              //     height: 13,
                              //   ),
                              //   Container(
                              //     width: 13,
                              //     height: 13,
                              //   ),
                              //   Container(
                              //     width: 13,
                              //     height: 13,
                              //   ),
                              //   Container(
                              //     width: 13,
                              //     height: 13,
                              //   ),
                              // ],
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
                children: featureList.map((e) => Container(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 194,
                                width: 358,
                                decoration: e.message_image==null?null:BoxDecoration(
                                    image: DecorationImage(
                                        image: MemoryImage(e.message_image),
                                        fit: BoxFit.fitHeight
                                    )
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.all(25),
                                  child:Text(e.short_title??'-',style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontWeight: FontWeight.w700,fontSize: 35,shadows: [
                                    Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 3.0,
                                      color: Colors.grey.withOpacity(0.7),
                                    ),
                                  ]),)
                              ),
                              Container(
                                  padding: EdgeInsets.all(15),
                                  child:Text(e.title??'-',textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontWeight: FontWeight.w400,fontStyle: FontStyle.italic,fontSize: 20,),)
                              ),
                            ],
                          ),
                        ),
                      ),
                      (featureList.last==e)
                          ?Positioned.fill(child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: ()async{
                                await prefs.setBool("first_time", false);
                                await Navigator.pushReplacementNamed(context, '/login');
                              },
                              child: Container(padding: EdgeInsets.all(25),child: Text('Mulai aplikasi',style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),decoration: TextDecoration.underline,fontWeight: FontWeight.w400,fontSize: 16,),)))
                        ],
                      ))
                          :Container(),
                    ],
                  ),
                )).toList(),
                // children: [
                //   Container(
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Container(
                //           height: 194,
                //           width: 358,
                //           decoration: BoxDecoration(
                //             image: DecorationImage(
                //               image: AssetImage('images/step1.png'),
                //               fit: BoxFit.fitHeight
                //             )
                //           ),
                //         ),
                //         Container(
                //           padding: EdgeInsets.all(25),
                //           child:Text('Simpan Point',style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontWeight: FontWeight.w700,fontSize: 35,shadows: [
                //             Shadow(
                //               offset: Offset(1.0, 1.0),
                //               blurRadius: 3.0,
                //               color: Colors.grey.withOpacity(0.7),
                //             ),
                //           ]),)
                //         ),
                //         Container(
                //             padding: EdgeInsets.all(15),
                //             child:Text('Dapatkan point dengan berbelanja produk kami',textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontWeight: FontWeight.w400,fontStyle: FontStyle.italic,fontSize: 20,),)
                //         ),
                //       ],
                //     ),
                //   ),
                //   Container(
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Container(
                //           height: 194,
                //           width: 358,
                //           decoration: BoxDecoration(
                //               image: DecorationImage(
                //                   image: AssetImage('images/step2.png'),
                //                   fit: BoxFit.fitHeight
                //               )
                //           ),
                //         ),
                //         Container(
                //             padding: EdgeInsets.all(25),
                //             child:Text('Tukar Point',style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontWeight: FontWeight.w700,fontSize: 35,shadows: [
                //               Shadow(
                //                 offset: Offset(1.0, 1.0),
                //                 blurRadius: 3.0,
                //                 color: Colors.grey.withOpacity(0.7),
                //               ),
                //             ]),)
                //         ),
                //         Container(
                //             padding: EdgeInsets.all(15),
                //             child:Text('Tukar point dengan voucher untuk mendapatkan diskon atau berbagai diskon lainnya',textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontWeight: FontWeight.w400,fontStyle: FontStyle.italic,fontSize: 20,),)
                //         ),
                //       ],
                //     ),
                //   ),
                //   Container(
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Container(
                //           height: 192,
                //           width: 265,
                //           decoration: BoxDecoration(
                //               image: DecorationImage(
                //                   image: AssetImage('images/step3.png'),
                //                   fit: BoxFit.fitWidth
                //               )
                //           ),
                //         ),
                //         Container(
                //             padding: EdgeInsets.all(25),
                //             child:Text('Berita Terbaru',style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontWeight: FontWeight.w700,fontSize: 35,),)
                //         ),
                //         Container(
                //             padding: EdgeInsets.all(15),
                //             child:Text('Dapatkan informasi berita dan promo terkini dari perusahaan kami',textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontWeight: FontWeight.w400,fontStyle: FontStyle.italic,fontSize: 20,),)
                //         ),
                //       ],
                //     ),
                //   ),
                //   Container(
                //     child: Stack(
                //       children: [
                //         Positioned.fill(
                //           child: Padding(
                //             padding: const EdgeInsets.all(25.0),
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               children: [
                //                 SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                //                 Container(
                //                   height: 364,
                //                   width: 367,
                //                   decoration: BoxDecoration(
                //                       image: DecorationImage(
                //                           image: AssetImage('images/step4.png'),
                //                           fit: BoxFit.fitWidth
                //                       )
                //                   ),
                //                 ),
                //                 Container(
                //                   padding: EdgeInsets.only(top:15),
                //                   child: Text("Selamat Bergabung\ndalam\nThamrin Club",textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: Color.fromRGBO(0, 0, 52, 1)),),
                //                 ),
                //                 Container(
                //                   padding: EdgeInsets.only(top:15),
                //                   child: Text("Kesetiaan dan kepuasan pelanggan adalah prioritas kami",textAlign: TextAlign.center,style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,fontWeight: FontWeight.w400,color: Color.fromRGBO(0, 0, 52, 1)),),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //         Positioned.fill(child: Column(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             InkWell(
                //                 onTap: ()async{
                //                   await prefs.setBool("first_time", false);
                //                   await Navigator.pushReplacementNamed(context, '/login');
                //                 },
                //                 child: Container(padding: EdgeInsets.all(25),child: Text('Mulai aplikasi',style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),decoration: TextDecoration.underline,fontWeight: FontWeight.w400,fontSize: 16,),)))
                //           ],
                //         )),
                //       ],
                //     ),
                //   ),
                // ],
              ),
            ),
          ],
        ),
      );
    }
  }
}