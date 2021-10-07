import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'CustomWidget/news_detail.dart';
import 'DataType/contents.dart';
import 'api/contents.dart';
import 'main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/io_client.dart';


class ContentList extends StatefulWidget {
  bool checkMyVoucher;
  ContentList({this.checkMyVoucher=false});

  @override
  _ContentListState createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  final search = new TextEditingController();
  List<Content> BannerList= [];
  List<Content> NewsList = [];
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  loadBanners()async{
    var res = await ContentApi().getContents("PROMOTIONS");
    if(res["STATUS"]==1){
      BannerList.clear();
      for(var i = 0;i<res["DATA"].length;i++){
        BannerList.add(Content.fromJson(res["DATA"][i]));
      }
      setState(() {
        globVar.isLoading = false;
      });
    }
    else{
      throw('Error fetching banners!');
    }
  }
  loadNews()async{
    setState(() {
      globVar.isLoading = true;
    });
    var res = await ContentApi().getContents("NEWS");
    if(res["STATUS"]==1){
      NewsList.clear();
      for(var i = 0;i<res["DATA"].length;i++){
        NewsList.add(Content.fromJson(res["DATA"][i]));
      }
    }
    else{
      throw('Error fetching ContentApi!');
    }
  }

  void _onRefresh() async{
    print("refreshing");
    try{
      await Future.delayed(Duration(milliseconds: 1000));
      await loadNews();
      await loadBanners();
      _refreshController.refreshCompleted();
    }
    catch(e){
      setState(() {
        globVar.isLoading = false;
      });
      _refreshController.refreshCompleted();
    }
  }

  void initialize ()async{
    try{
      await loadNews();
      await loadBanners();
    }
    catch(e){
      // utils.toast(e.message??e,type:'ERROR');
      utils.toast("Error dalam memperbarui data. Cek koneksi internet.",type:'ERROR');
      setState(() {
        globVar.isLoading = false;
      });
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context).popUntil((route) => route.settings.name == '/home' || route.settings.name == '/');
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top:25.0,left:25.0,right:25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                  Center(
                    child: Container(
                      width: 335,
                      height:184,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/news.png"),
                          fit: BoxFit.fitWidth
                        )
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15,bottom:20),
                    alignment: Alignment.centerLeft,
                    child: Text('Promo & Diskon',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: Color.fromRGBO(0, 0, 52, 1)),)
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 188,
                    child:
                    (globVar.isLoading)
                    ?Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 260,
                                height: 116,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(237, 237, 237, 1)
                                ),
                              ),
                              SizedBox(width: 28,),
                              Container(
                                width: 260,
                                height: 116,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(237, 237, 237, 1)
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(padding: EdgeInsets.all(2),width: MediaQuery.of(context).size.width,child: LinearProgressIndicator(backgroundColor: Colors.grey,valueColor: new AlwaysStoppedAnimation<Color>(Colors.white))),
                      ],
                    )
                    :(BannerList.length==0)?
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 116,
                      decoration: BoxDecoration(
                          // color: Color.fromRGBO(237, 237, 237, 1),
                          image: DecorationImage(
                                image: AssetImage("images/empty_banner.png"),
                              fit: BoxFit.scaleDown
                          ),
                      ),
                      padding: EdgeInsets.only(left: 15,top: 45),
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.4,
                        child :Text(
                          "Tidak Ada Promo Untuk Saat Ini",
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                  blurRadius: 3,
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: Offset(0, 3),
                                ),
                              ],
                              color: Color.fromRGBO(0, 0, 54, 1),
                              fontSize: 14,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w700,
                              height: 1.5),
                        )
                      ),
                    )
                    :ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: BannerList.length,
                        itemBuilder: (context,indx){
                          return InkWell(
                            onTap: ()async{
                              await Navigator.push(context,MaterialPageRoute(builder: (context)=>NewsDetail(BannerList[indx])));
                              // _onRefresh();
                              },
                            child: Container(
                              padding: EdgeInsets.only(right: 28),
                              width: 280,
                              height: 188,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    cacheManager: CacheManager(
                                      Config(
                                        'testCache',
                                        fileService: HttpFileService(
                                          httpClient: http,
                                        ),
                                      ),
                                    ),
                                    httpHeaders: {
                                      "Authorization":"bearer ${globVar.tokenRest.token}"
                                    },
                                    imageUrl: BannerList[indx].message_image,
                                    imageBuilder: (context, imageProvider) => Container(
                                      height: 116,
                                      width: 280,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          image: DecorationImage(
                                              fit: BoxFit.fitHeight,
                                              alignment: Alignment.center,
                                              image: imageProvider,
                                          )
                                      ),
                                    ),
                                    placeholder: (context, url) => Container(
                                        padding: EdgeInsets.all(2),
                                        width: 20,
                                        child: LinearProgressIndicator(
                                          backgroundColor: Colors.grey,
                                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                                        )),
                                    errorWidget: (context, url, error){
                                      if(error == HandshakeException){
                                        if(!useLocal){
                                          setState(() {
                                            useLocal = true;
                                            http = IOClient(HttpClient(context: clientContext));
                                          });
                                        }
                                      }
                                      return Icon(Icons.error);
                                    },
                                  ),
                                  // Container(
                                  //     height: 116,
                                  //     width: 280,
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(25),
                                  //       image: DecorationImage(
                                  //         fit: BoxFit.fitHeight,
                                  //         alignment: Alignment.center,
                                  //         image: MemoryImage(BannerList[indx].message_image)
                                  //       )
                                  //     ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(BannerList[indx].title??"-",style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontSize: 15,fontWeight: FontWeight.w700),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0,right:10.0),
                                    child: Text((BannerList[indx].date!=null)?Moment.fromDateTime(BannerList[indx].date).fromNow(true) + " ago":"-",style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontSize: 10,fontStyle: FontStyle.italic,fontWeight: FontWeight.w400),),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      alignment: Alignment.centerLeft,
                      child: Text('Kabar Terbaru',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: Color.fromRGBO(0, 0, 52, 1)),)
                  ),
                  Expanded(
                    child:
                    (globVar.isLoading)
                        ?SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 150,
                                height: 90,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(237, 237, 237, 1)
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left:25),
                                  height: 90,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 17,
                                        color: Color.fromRGBO(237, 237, 237, 1),
                                      ),
                                      Container(
                                        height: 17,
                                        width: 85,
                                        color: Color.fromRGBO(237, 237, 237, 1),
                                      ),
                                      Container(
                                        height: 17,
                                        width: 60,
                                        color: Color.fromRGBO(237, 237, 237, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 19,),
                          Row(
                            children: [
                              Container(
                                width: 150,
                                height: 90,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(237, 237, 237, 1)
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left:25),
                                  height: 90,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 17,
                                        color: Color.fromRGBO(237, 237, 237, 1),
                                      ),
                                      Container(
                                        height: 17,
                                        width: 85,
                                        color: Color.fromRGBO(237, 237, 237, 1),
                                      ),
                                      Container(
                                        height: 17,
                                        width: 60,
                                        color: Color.fromRGBO(237, 237, 237, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                        :(NewsList.length==0)?
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Container(
                        height: 114,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 54, 1),
                                    borderRadius: BorderRadius.circular(5.0)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      height:30,
                                      width:120,
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage("images/ThamrinfullBlack.png"),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text("Belum ada berita baru, nih",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color.fromRGBO(255, 255, 255, 1),
                                              fontSize: 12,
                                              letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.w700,
                                              height: 1
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child:Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(5.0),
                                      topRight: Radius.circular(5.0),
                                    ),
                                  ),
                                  child: Image(
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage("images/empty_news.png"),
                                    gaplessPlayback: true,
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    )
                    :ListView.builder(
                      padding: EdgeInsets.all(0),
                        itemCount: NewsList.length,
                        itemBuilder: (context,indx){
                          return InkWell(
                            onTap: ()async{
                              await Navigator.push(context,MaterialPageRoute(builder: (context)=>NewsDetail(NewsList[indx])));
                              // _onRefresh();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 19),
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    cacheManager: CacheManager(
                                      Config(
                                        'testCache',
                                        fileService: HttpFileService(
                                          httpClient: http,
                                        ),
                                      ),
                                    ),
                                    httpHeaders: {
                                      "Authorization":"bearer ${globVar.tokenRest.token}"
                                    },
                                    imageUrl: NewsList[indx].message_image,
                                    imageBuilder: (context, imageProvider) => Container(
                                      width: 150,
                                      height: 90,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          image: DecorationImage(
                                              fit: BoxFit.fitHeight,
                                              alignment: Alignment.center,
                                              image: imageProvider
                                          )
                                      ),
                                    ),
                                    placeholder: (context, url) => Container(
                                        padding: EdgeInsets.all(2),
                                        width: 20,
                                        child: LinearProgressIndicator(
                                          backgroundColor: Colors.grey,
                                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                                        )),
                                    errorWidget: (context, url, error){
                                      if(error == HandshakeException){
                                        if(!useLocal){
                                          setState(() {
                                            useLocal = true;
                                            http = IOClient(HttpClient(context: clientContext));
                                          });
                                        }
                                      }
                                      return Icon(Icons.error);
                                    },
                                  ),
                                  // Container(
                                  //   width: 150,
                                  //   height: 90,
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(15),
                                  //       image: DecorationImage(
                                  //           fit: BoxFit.fitHeight,
                                  //           alignment: Alignment.center,
                                  //           image: MemoryImage(NewsList[indx].message_image)
                                  //       )
                                  //   ),
                                  // ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left:25),
                                      height: 90,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(NewsList[indx].title??"-",style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontSize: 15,fontWeight: FontWeight.w700),),
                                          Text((NewsList[indx].date!=null)?Moment.fromDateTime(BannerList[indx].date).fromNow(true) + " ago":"-",style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontSize: 10,fontStyle: FontStyle.italic,fontWeight: FontWeight.w400),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          // return Container(
                          //   width: 280,
                          //   height: 188,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Container(
                          //         height: 116,
                          //         width: 280,
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(25),
                          //             image: DecorationImage(
                          //                 fit: BoxFit.fitHeight,
                          //                 alignment: Alignment.center,
                          //                 image: MemoryImage(NewsList[indx].message_image)
                          //             )
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(10.0),
                          //         child: Text(NewsList[indx].title??"-",style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontSize: 15,fontWeight: FontWeight.w700),),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.only(left:10.0,right:10.0),
                          //         child: Text((NewsList[indx].date!=null)?Moment.fromDateTime(NewsList[indx].date).fromNow(true) + " ago":"-",style: TextStyle(color: Color.fromRGBO(0, 0, 52, 1),fontSize: 10,fontStyle: FontStyle.italic,fontWeight: FontWeight.w400),),
                          //       ),
                          //     ],
                          //   ),
                          // );
                        }
                    ),
                  ),
                ],
              ),
            ),
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
                      onTap: ()async{
                        await Navigator.pushNamed(context, "/vouchers");
                      },
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
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: (){
        //     showMyVoucher();
        //   },
        //     isExtended: true,
        //     label: const Text('My Voucher'),
        //     backgroundColor: Color.fromRGBO(207,79,79,1),
        //     icon: Icon(FontAwesomeIcons.shoppingBag),
        // ),
      ),
    );
  }
}