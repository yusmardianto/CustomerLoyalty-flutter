import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'CustomShape/voucher_shape.dart';
import 'CustomWidget/bottom_appbar.dart';
import 'CustomWidget/news_detail.dart';
import 'CustomWidget/voucher_detail.dart';
import 'DataType/contents.dart';
import 'DataType/voucher.dart';
import 'api/auths.dart';
import 'api/contents.dart';
import 'api/users.dart';
import 'api/vouchers.dart';
import 'main.dart';
import 'vouchers_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  List<Content> BannerList = [];
  List<Content> NewsList = [];
  List<Content> MerchantList = [];
  List<Voucher> voucherList = [];
  List<Content> CSList = [];
  List<Content> FAQList = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int bannerFocus, myVoucherFocus, availVoucherFocus;

  agreementDialog(context, agreement) async {
    ScrollController _scontroller = ScrollController();
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: new SimpleDialog(
              contentPadding: EdgeInsets.all(0.0),
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Scrollbar(
                        isAlwaysShown: true,
                        controller: _scontroller,
                        child: SingleChildScrollView(
                            controller: _scontroller,
                            child: HtmlWidget(
                              agreement["DATA"],
                              textStyle: TextStyle(fontSize: 12),
                            )),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            top: 15, bottom: 15, left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            new TextButton(
                              child: new Text(
                                "Cancel",
                                style: TextStyle(color: Colors.grey),
                              ),
                              onPressed: () async {
                                var agree = await Users().updateAgreement(
                                    'LEGAL_AGREEMENT',
                                    'FALSE',
                                    globVar.user.CUST_ID,
                                    globVar.auth.corp);
                                print(
                                    "test ${agreement["REQUIRED"]} $agreement");
                                if (agree["STATUS"]) {
                                  if (agreement["REQUIRED"] == "TRUE") {
                                    Navigator.of(context).pop(false);
                                  } else
                                    Navigator.of(context).pop(true);
                                } else {
                                  utils.toast(agree["DATA"], type: "ERROR");
                                }
                              },
                            ),
                            new TextButton(
                              child: new Text("Agree"),
                              onPressed: () async {
                                var agree = await Users().updateAgreement(
                                    'LEGAL_AGREEMENT',
                                    'TRUE',
                                    globVar.user.CUST_ID,
                                    globVar.auth.corp);
                                if (agree["STATUS"])
                                  Navigator.of(context).pop(true);
                                else {
                                  utils.toast(agree["DATA"], type: "ERROR");
                                }
                              },
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget banner() {
    List<Widget> item = [];
    CarouselOptions options = new CarouselOptions(
        height: 114.0,
        onPageChanged: (indx, reason) {
          setState(() {
            bannerFocus = indx;
          });
        },
        enableInfiniteScroll: BannerList.length != 1 && BannerList.length != 0,
        disableCenter: true,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        autoPlay: true,
        autoPlayAnimationDuration: Duration(seconds: 3));
    if (globVar.isLoading ?? true) {
      item.add(Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 114,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(1.0, 1.0), color: Colors.grey, blurRadius: 3)
          ],
          color: Color.fromRGBO(237, 237, 237, 1),
        ),
      ));
    } else {
      if (BannerList.length == 0) {
        item.add(InkWell(
          onTap: () async {
            // await Navigator.pushNamed(context, "/news");
          },
          child: Container(
            padding: EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: Text(
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
                  height: 1),
            ),
            width: MediaQuery.of(context).size.width,
            height: 114,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/empty_banner.png"),
                  fit: BoxFit.scaleDown),
              boxShadow: [
                BoxShadow(
                    offset: Offset(1.0, 1.0), color: Colors.grey, blurRadius: 3)
              ],
              color: Color.fromRGBO(237, 237, 237, 1),
            ),
          ),
        ));
      } else {
        for (var idx = 0; idx < BannerList.length; idx++) {
          Content i = BannerList[idx];
          Widget banner = Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewsDetail(i)));
                  // await Users()
                  //     .refreshUser(globVar.user.CUST_ID, globVar.auth.corp);
                  // loadBanners(dontWait:true);
                  // setState(() {});
                },
                child: CachedNetworkImage(
                  httpHeaders: {
                    "Authorization": "bearer ${globVar.tokenRest.token}"
                  },
                  imageUrl: i.message_image,
                  imageBuilder: (context, imageProvider) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: 114,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(1.0, 1.0),
                              color: Colors.grey,
                              blurRadius: 3)
                        ],
                        color: Color.fromRGBO(237, 237, 237, 1),
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: imageProvider,
                        )),
                  ),
                  placeholder: (context, url) => Padding(
                    padding: const EdgeInsets.only(top:50.0,bottom:50.0,left:150,right:150),
                    child: Container(
                        width: 50,
                        height:20,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.grey,
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white),
                        )),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 114,
                //   decoration: BoxDecoration(
                //       boxShadow: [
                //         BoxShadow(
                //             offset: Offset(1.0, 1.0),
                //             color: Colors.grey,
                //             blurRadius: 3)
                //       ],
                //       color: Color.fromRGBO(237, 237, 237, 1),
                //       image: (i.message_image == null)
                //           ? null
                //           : DecorationImage(
                //               fit: BoxFit.fitHeight,
                //               image: MemoryImage(i.message_image),
                //             )),
                // ),
              );
            },
          );
          item.add(banner);
        }
      }
    }

    return Container(
      child: Column(
        children: [
          CarouselSlider(
            options: options,
            items: item,
          ),
          Container(
            height: 28,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: (BannerList.length == 0)
                ? Container(
                    padding: EdgeInsets.all(2),
                    width: 20,
                    child: (globVar.isLoading ?? false)
                        ? LinearProgressIndicator(
                            backgroundColor: Colors.grey,
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : null)
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: BannerList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(left: 2, right: 2),
                      child: Container(
                        height: (bannerFocus == index) ? 8 : 4,
                        width: (bannerFocus == index) ? 8 : 4,
                        decoration: BoxDecoration(
                            color: (bannerFocus == index)
                                ? Colors.redAccent
                                : Colors.grey,
                            shape: BoxShape.circle),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget availVouchers() {
    return (globVar.isLoading ?? true)
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                    height: 96,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color.fromRGBO(237, 237, 237, 1))),
              ),
              Container(
                  padding: EdgeInsets.all(2),
                  width: 20,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ))
            ],
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 18, left: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Tukarkan Point",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VouchersList(
                                      checkMyVoucher: false,
                                    )));
                        await Users().refreshUser(
                            globVar.user.CUST_ID, globVar.auth.corp);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                          "Semua",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromRGBO(117, 83, 83, 0.81),
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              (voucherList.length == 0)
                  ? Padding(
                      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(238, 238, 238, 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        height: 97,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 54, 1),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      height: 30,
                                      width: 120,
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(
                                          "images/ThamrinfullBlack.png"),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "Belum ada Reward yang bisa ditukar, nih",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontSize: 12,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.w700,
                                              height: 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(5.0),
                                      topRight: Radius.circular(5.0),
                                    ),
                                  ),
                                  child: Image(
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage("images/empty_avail.png"),
                                    gaplessPlayback: true,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction:
                                  1 - (62 / MediaQuery.of(context).size.width),
                              height: 96,
                              enableInfiniteScroll: true,
                              autoPlay: false,
                              // autoPlayAnimationDuration: Duration(seconds: 3),
                              onPageChanged: (index, reason) {
                                setState(() {
                                  availVoucherFocus = index;
                                });
                              },
                            ),
                            items: voucherList
                                .map((item) => InkWell(
                                      // onTap: ()=>VoucherDialog().showDialog(globVar.myVouchers[index], context),
                                      onTap: () async {
                                        var refresh = await VoucherDialog()
                                            .showVoucherDetails(item, context);
                                        // var refresh = await showVoucherDetails(item);
                                        if (refresh ?? false)
                                          await loadAvailableVoucher();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 152,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0.3),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white,
                                              ),
                                              child: CustomPaint(
                                                painter: VoucherPainter(
                                                    item.SHORT_DESC),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(12),
                                              height: 152,
                                              alignment: Alignment.centerRight,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "VOUCHERS",
                                                            style: GoogleFonts
                                                                .robotoCondensed(
                                                              textStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            item.CAMPAIGN_TYPE ??
                                                                "-",
                                                            style: GoogleFonts
                                                                .robotoCondensed(
                                                              textStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .amber,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            "POTONGAN",
                                                            style: GoogleFonts
                                                                .robotoCondensed(
                                                              textStyle:
                                                                  TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        57,
                                                                        153,
                                                                        184,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10.0,
                                                                    bottom:
                                                                        10.0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "${utils.thousandSeperator(item.REWARD_VALUE) ?? '-'}",
                                                                  style: GoogleFonts
                                                                      .robotoMono(
                                                                    textStyle:
                                                                        TextStyle(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              14,
                                                                              60,
                                                                              74,
                                                                              1),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              5),
                                                                  child: Icon(
                                                                      FontAwesomeIcons
                                                                          .coins,
                                                                      size: 18,
                                                                      color: Colors
                                                                          .amberAccent),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  // Text(item.PERIOD,style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Color.fromRGBO(57,153,184,1),fontWeight: FontWeight.w700,fontSize: 15, ),),),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        Container(
                          height: 28,
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: voucherList.length,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(left: 2, right: 2),
                              child: Container(
                                height: (availVoucherFocus == index) ? 8 : 4,
                                width: (availVoucherFocus == index) ? 8 : 4,
                                decoration: BoxDecoration(
                                    color: (availVoucherFocus == index)
                                        ? Colors.redAccent
                                        : Colors.grey,
                                    shape: BoxShape.circle),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
            ],
          );
  }

  Widget news() {
    return (globVar.isLoading ?? true)
        ? Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: 90,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, indx) => Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              color: Color.fromRGBO(237, 237, 237, 1),
                              width: 175,
                              height: 89,
                            ),
                            Container(
                              color: Color.fromRGBO(237, 237, 237, 1),
                              width: 175,
                              height: 89,
                            )
                          ],
                        ),
                      )),
            ),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 18, left: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Kabar Terbaru dari Thamrin ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                          // (globVar.isLoading)?Container(height: 15,width: 15,child: CircularProgressIndicator()):Text("${globVar.myVouchers.length}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                          // Text(" voucher",style: TextStyle(
                          // fontWeight: FontWeight.w500,fontSize: 18),),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // Navigator.pushNamed(context, "/vouchers",);
                        await Navigator.pushNamed(context, "/news");
                        await Users().refreshUser(
                            globVar.user.CUST_ID, globVar.auth.corp);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                          "Semua",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromRGBO(65, 57, 57, 0.81),
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              (NewsList.length == 0)
                  ? Padding(
                      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(238, 238, 238, 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        height: 97,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 54, 1),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      height: 30,
                                      width: 120,
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(
                                          "images/ThamrinfullBlack.png"),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "Belum ada berita baru, nih",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontSize: 12,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.w700,
                                              height: 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Container(
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
                                )),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Container(
                            height: 90,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: (NewsList.length / 2).ceil(),
                              itemBuilder: (context, indx) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsDetail(
                                                          NewsList[indx * 2])));
                                        },
                                        child: CachedNetworkImage(
                                          httpHeaders: {
                                            "Authorization":
                                                "bearer ${globVar.tokenRest.token}"
                                          },
                                          imageUrl:
                                              NewsList[indx * 2].message_image,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: (NewsList[indx * 2]
                                                        .message_image !=
                                                    null)
                                                ? BoxDecoration(
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.fitWidth))
                                                : null,
                                            width: 175,
                                            height: 89,
                                            child: (NewsList[indx * 2]
                                                        .message_image ==
                                                    null)
                                                ? Center(
                                                    child: Text("No Image"),
                                                  )
                                                : null,
                                          ),
                                          placeholder: (context, url) =>
                                              Container(
                                                  padding: EdgeInsets.all(2),
                                                  width: 20,
                                                  child:
                                                      LinearProgressIndicator(
                                                    backgroundColor:
                                                        Colors.grey,
                                                    valueColor:
                                                        new AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.white),
                                                  )),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                        // Container(
                                        //   decoration:
                                        //   (NewsList[indx * 2].message_image !=
                                        //       null)
                                        //       ? BoxDecoration(
                                        //       image: DecorationImage(
                                        //           image: MemoryImage(
                                        //               NewsList[indx * 2]
                                        //                   .message_image),
                                        //           fit: BoxFit.fitWidth))
                                        //       : null,
                                        //   width: 175,
                                        //   height: 89,
                                        //   child:
                                        //   (NewsList[indx * 2].message_image ==
                                        //       null)
                                        //       ? Center(
                                        //     child: Text("No Image"),
                                        //   )
                                        //       : null,
                                        // ),
                                      ),
                                      ((indx * 2 + 1) <= (NewsList.length - 1))
                                          ? InkWell(
                                              onTap: () async {
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NewsDetail(NewsList[
                                                                indx * 2 +
                                                                    1])));
                                              },
                                              child: CachedNetworkImage(
                                                httpHeaders: {
                                                  "Authorization":
                                                      "bearer ${globVar.tokenRest.token}"
                                                },
                                                imageUrl: NewsList[indx * 2 + 1]
                                                    .message_image,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  width: 175,
                                                  height: 89,
                                                  decoration: (NewsList[
                                                                  indx * 2 + 1]
                                                              .message_image !=
                                                          null)
                                                      ? BoxDecoration(
                                                          image: DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit
                                                                  .fitWidth))
                                                      : null,
                                                  child: (NewsList[indx * 2 + 1]
                                                              .message_image ==
                                                          null)
                                                      ? Center(
                                                          child:
                                                              Text("No Image"),
                                                        )
                                                      : null,
                                                ),
                                                placeholder: (context, url) =>
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(2),
                                                        width: 20,
                                                        child:
                                                            LinearProgressIndicator(
                                                          backgroundColor:
                                                              Colors.grey,
                                                          valueColor:
                                                              new AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.white),
                                                        )),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                              // Container(
                                              //   width: 175,
                                              //   height: 89,
                                              //   decoration: (NewsList[
                                              //   indx * 2 + 1]
                                              //       .message_image !=
                                              //       null)
                                              //       ? BoxDecoration(
                                              //       image: DecorationImage(
                                              //           image: MemoryImage(
                                              //               NewsList[
                                              //               indx * 2 +
                                              //                   1]
                                              //                   .message_image),
                                              //           fit: BoxFit.fitWidth))
                                              //       : null,
                                              //   child: (NewsList[indx * 2 + 1]
                                              //       .message_image ==
                                              //       null)
                                              //       ? Center(
                                              //     child: Text("No Image"),
                                              //   )
                                              //       : null,
                                              // ),
                                            )
                                          : Container(
                                              width: 175,
                                              height: 89,
                                            ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          );
  }

  Widget myVouchers() {
    return (globVar.isLoading ?? true)
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                    height: 96,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color.fromRGBO(237, 237, 237, 1))),
              ),
              Container(
                  padding: EdgeInsets.all(2),
                  width: 20,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ))
            ],
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 18, left: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            'Voucher Saya',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 54, 1),
                                fontFamily: 'Roboto',
                                fontSize: 18,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.w400,
                                height: 1),
                          )
                          // (globVar.isLoading)?Container(height: 15,width: 15,child: CircularProgressIndicator()):Text("${globVar.myVouchers.length}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                          // Text(" voucher",style: TextStyle(
                          // fontWeight: FontWeight.w500,fontSize: 18),),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VouchersList(
                                      checkMyVoucher: true,
                                    )));
                        await Users().refreshUser(
                            globVar.user.CUST_ID, globVar.auth.corp);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                          "Semua",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(117, 83, 83, 0.81),
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              (globVar.myVouchers.length == 0)
                  ? Padding(
                      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(238, 238, 238, 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        height: 97,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 54, 1),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      height: 30,
                                      width: 120,
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(
                                          "images/ThamrinfullBlack.png"),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "Kamu belum punya voucher, nih",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontSize: 12,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.w700,
                                              height: 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(5.0),
                                      topRight: Radius.circular(5.0),
                                    ),
                                  ),
                                  child: Image(
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage(
                                        "images/empty_myvoucher.png"),
                                    gaplessPlayback: true,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction:
                                  1 - (62 / MediaQuery.of(context).size.width),
                              height: 96,
                              enableInfiniteScroll: true,
                              autoPlay: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  myVoucherFocus = index;
                                });
                              },
                              // autoPlayAnimationDuration: Duration(seconds: 3)
                            ),
                            items: globVar.myVouchers
                                .map((item) => InkWell(
                                      onTap: () async {
                                        var result = await Vouchers()
                                            .voucherDetails(
                                                item.LOYALTY_CAMPAIGN_ID);
                                        if (result["STATUS"] == 1 &&
                                            result["DATA"].length > 0) {
                                          var details = new Voucher.fromJson(
                                              result["DATA"][0]);
                                          await VoucherDialog()
                                              .showVoucherDetails(
                                                  details, context,
                                                  rewardId: item
                                                      .LOYALTY_CUST_REWARD_ID);
                                          await loadVoucher();
                                          setState(() {});
                                        } else {
                                          bool genBarcode = await showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  SimpleDialog(
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
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )),
                                                      SizedBox(height: 15),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          FlatButton(
                                                              minWidth: 120,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0),
                                                                  side: BorderSide(
                                                                      color: Color.fromRGBO(
                                                                          64,
                                                                          64,
                                                                          222,
                                                                          1))),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context,
                                                                    false);
                                                              },
                                                              child: Text(
                                                                "Batal",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              )),
                                                          SizedBox(width: 15),
                                                          FlatButton(
                                                              minWidth: 120,
                                                              color:
                                                                  Colors.green,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0)),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context,
                                                                    true);
                                                              },
                                                              child: Text(
                                                                "Gunakan",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                        side: BorderSide(
                                                            color: Colors
                                                                .transparent)),
                                                    contentPadding:
                                                        EdgeInsets.all(20),
                                                  ));

                                          if (genBarcode ?? false) {
                                            Future future = Vouchers()
                                                .useVoucher(item
                                                    .LOYALTY_CUST_REWARD_ID);
                                            var res =
                                                await utils.showLoadingFuture(
                                                    context, future);
                                            if (res["STATUS"]) {
                                              print(res["DATA"]);
                                              await utils.genBarcode(
                                                  context,
                                                  res["DATA"]
                                                      ["transaction_code"],
                                                  res["DATA"]["expired"]);
                                              await Users().refreshUser(
                                                  globVar.user.CUST_ID,
                                                  globVar.auth.corp);
                                              setState(() {});
                                            } else {
                                              utils.toast(res["DATA"],
                                                  type: "ERROR");
                                            }
                                          }
                                        }
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            height: 152,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 0.3),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                            child: CustomPaint(
                                              painter: VoucherPainter(
                                                  item.DESCRIPTION),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            padding: EdgeInsets.all(12),
                                            height: 152,
                                            alignment: Alignment.centerRight,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "VOUCHERS",
                                                          style: GoogleFonts
                                                              .robotoCondensed(
                                                            textStyle:
                                                                TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          item.COUPON ?? "-",
                                                          style: GoogleFonts
                                                              .robotoCondensed(
                                                            textStyle:
                                                                TextStyle(
                                                              color:
                                                                  Colors.amber,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          "POTONGAN",
                                                          style: GoogleFonts
                                                              .robotoCondensed(
                                                            textStyle:
                                                                TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      57,
                                                                      153,
                                                                      184,
                                                                      1),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 15.0,
                                                                  bottom: 15.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "${item.REWARD_VALUE ?? '-'}",
                                                                style: GoogleFonts
                                                                    .robotoMono(
                                                                  textStyle:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            14,
                                                                            60,
                                                                            74,
                                                                            1),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5),
                                                                child: Icon(
                                                                    FontAwesomeIcons
                                                                        .coins,
                                                                    size: 18,
                                                                    color: Colors
                                                                        .amberAccent),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                // Text(item.PERIOD,style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Color.fromRGBO(57,153,184,1),fontWeight: FontWeight.w700,fontSize: 15, ),),),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        Container(
                          height: 28,
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: globVar.myVouchers.length,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(left: 2, right: 2),
                              child: Container(
                                height: (myVoucherFocus == index) ? 8 : 4,
                                width: (myVoucherFocus == index) ? 8 : 4,
                                decoration: BoxDecoration(
                                    color: (myVoucherFocus == index)
                                        ? Colors.redAccent
                                        : Colors.grey,
                                    shape: BoxShape.circle),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
            ],
          );
  }

  Widget supports() {
    List<Widget> CS = [
      Icon(
        FontAwesomeIcons.phoneSquareAlt,
        size: 60,
      ),
      SizedBox(height: 15),
      Center(
          child: Text(
        "Kami tersedia dalam",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ))
    ];
    List<Widget> FAQ = [
      Icon(
        FontAwesomeIcons.questionCircle,
        size: 60,
      ),
      SizedBox(height: 15),
      Center(
          child: Text(
        "Have question?",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      )),
    ];
    CSList.forEach((element) {
      String url =
          (element.message_body != null || element.message_body.contains('<'))
              ? element.message_body.substring(
                  element.message_body.indexOf('>') + 1,
                  element.message_body.lastIndexOf('</'))
              : null;
      CS.add(Divider());
      CS.add(InkWell(
        onTap: () => utils.launchBrowserURL(url.trim()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CachedNetworkImage(
              httpHeaders: {
                "Authorization": "bearer ${globVar.tokenRest.token}"
              },
              imageUrl: element.message_image,
              imageBuilder: (context, imageProvider) => Image(
                image: imageProvider,
                height: 33,
                width: 33,
                fit: BoxFit.fitWidth,
              ),
              placeholder: (context, url) => Container(
                  padding: EdgeInsets.all(2),
                  width: 20,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  )),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            // Image(
            //   image: MemoryImage(element.message_image),
            //   height: 33,
            //   width: 33,
            //   fit: BoxFit.fitWidth,
            // ),
            Text(
              element.short_title,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ));
    });
    if (CSList.length == 0) {
      CS.add(Divider());
      CS.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Informasi ini belum tersedia",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          )
        ],
      ));
    }
    FAQList.forEach((element) {
      FAQ.add(Divider());
      FAQ.add(InkWell(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewsDetail(element))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            element.short_title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
      ));
    });
    if (FAQList.length == 0) {
      FAQ.add(Divider());
      FAQ.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Informasi ini belum tersedia",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          )
        ],
      ));
    }
    return (globVar.isLoading ?? true)
        ? Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: 90,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, indx) => Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              color: Color.fromRGBO(237, 237, 237, 1),
                              width: 175,
                              height: 89,
                            ),
                            Container(
                              color: Color.fromRGBO(237, 237, 237, 1),
                              width: 175,
                              height: 89,
                            )
                          ],
                        ),
                      )),
            ),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 18, left: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Hubungi Kami",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Container(
                        height: 90,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //No Telp WA INSTA DLL
                              InkWell(
                                onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (context) => SimpleDialog(
                                            children: CS,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                side: BorderSide(
                                                    color: Colors.transparent)),
                                            contentPadding: EdgeInsets.all(20),
                                          ));
                                },
                                child: Container(
                                  width: 175,
                                  height: 89,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage('images/cs.png'),
                                    fit: BoxFit.fitHeight,
                                  )),
                                ),
                              ),
                              //FAQ
                              InkWell(
                                onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (context) => SimpleDialog(
                                            children: FAQ,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                side: BorderSide(
                                                    color: Colors.transparent)),
                                            contentPadding: EdgeInsets.all(20),
                                          ));
                                },
                                child: Container(
                                  width: 175,
                                  height: 89,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage('images/faq.png'),
                                    fit: BoxFit.cover,
                                  )),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ],
          );
  }

  Widget merchant() {
    double width = 123;
    double height = 159;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 18, left: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Text(
                      "Siap Melayani Anda",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                    // (globVar.isLoading)?Container(height: 15,width: 15,child: CircularProgressIndicator()):Text("${globVar.myVouchers.length}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                    // Text(" voucher",style: TextStyle(
                    // fontWeight: FontWeight.w500,fontSize: 18),),
                  ],
                ),
              ),
              // InkWell(
              //   onTap: () async {
              //     await Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => VouchersList(
              //               checkMyVoucher: true,
              //             )));
              //     await Users().refreshUser(
              //         globVar.user.CUST_ID, globVar.auth.corp);
              //     setState(() {});
              //   },
              //   child: Container(
              //     padding: EdgeInsets.only(right: 15),
              //     child: Text(
              //       "Semua",
              //       style: TextStyle(
              //           decoration: TextDecoration.underline,
              //           fontWeight: FontWeight.w300,
              //           fontSize: 14),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Container(
          height: height + 23,
          width: MediaQuery.of(context).size.width,
          child: (globVar.isLoading ?? true)
              ? ListView.separated(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    width: 10,
                  ),
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  itemBuilder: (context, index) => Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(237, 237, 237, 1),
                    ),
                  ),
                )
              : ListView.separated(
                  itemCount: MerchantList.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    width: 10,
                  ),
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  itemBuilder: (context, index) {
                    Content i = MerchantList[index];
                    return InkWell(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsDetail(i)));
                        await Users().refreshUser(
                            globVar.user.CUST_ID, globVar.auth.corp);
                        setState(() {});
                      },
                      child: Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.3),
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          child: Column(children: <Widget>[
                            CachedNetworkImage(
                              httpHeaders: {
                                "Authorization":
                                    "bearer ${globVar.tokenRest.token}"
                              },
                              imageUrl: i.message_image,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: (i.message_image != null)
                                    ? BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fitWidth))
                                    : null,
                                width: 175,
                                height: 89,
                                child: (i.message_image == null)
                                    ? Center(
                                        child: Text("No Image"),
                                      )
                                    : null,
                              ),
                              placeholder: (context, url) => Container(
                                  padding: EdgeInsets.all(2),
                                  width: 20,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  )),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            // Container(
                            //   width: width,
                            //   height: height * 0.61,
                            //   decoration: BoxDecoration(
                            //     image: (i.message_image == null)
                            //         ? null
                            //         : DecorationImage(
                            //             image: MemoryImage(i.message_image),
                            //             fit: BoxFit.fill),
                            //   ),
                            // ),
                            Container(
                                padding: EdgeInsets.all(8),
                                width: width,
                                height: height * 0.39,
                                child: Column(
                                  children: [
                                    Container(
                                      width: width,
                                      child: Text(
                                        i.short_title ?? '-',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 54, 1),
                                            fontSize: 13,
                                            letterSpacing:
                                                0 /*percentages not used in flutter. defaulting to zero*/,
                                            fontWeight: FontWeight.w700,
                                            height: 1),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.bottomRight,
                                        width: width,
                                        child: Text(
                                          "Lihat detail",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Color.fromRGBO(
                                                  117, 83, 83, 0.81),
                                              fontSize: 10,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w700,
                                              height: 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ])),
                    );
                  },
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (globVar.user == null) return Container(color: Colors.white);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: () async {
          await exitAppDialog();
          return false;
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
                child: Container(color: Color.fromRGBO(0, 0, 46, 1)),
              ),
              Expanded(
                child: SmartRefresher(
                  // header: WaterDropHeader(),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        header(),
                        banner(),
                        myVouchers(),
                        news(),
                        availVouchers(),
                        merchant(),
                        supports(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppbar(_onRefresh, 1),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPop() {
    //pop from home
    // final route = ModalRoute.of(context).settings.name;
    // print('didPop route: $route');
  }

  @override
  void didPopNext() async {
    //popped to home
    print('poped to home');
    // final route = ModalRoute.of(context).settings.name;
    if ((ModalRoute.of(context).settings.name == '/home' ||
        ModalRoute.of(context).settings.name == '/')) {
      var isFinish = await Users().refreshUser(
          globVar.user.CUST_ID, globVar.auth.corp,
          check_session: true);
      if (isFinish == null)
        Navigator.pushNamed(context, '/login');
      else {
        if (globVar.auth.force_change == 'TRUE') {
          await forcePasswordChange(context);
          await Users().refreshUser(globVar.user.CUST_ID, globVar.auth.corp);
        }
        var agreement = await Users().checkAgreement(
            'LEGAL_AGREEMENT', globVar.user.CUST_ID, globVar.auth.corp);
        if (agreement["STATUS"] && agreement["DATA"] != 'y') {
          var result = await agreementDialog(context, agreement);
          if (!(result ?? false)) {
            // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            exit(0);
          }
        }
        loadVoucher();
        loadAvailableVoucher();
        loadNews();
        loadMerchants();
        loadBanners(dontWait:true);
      }
    }
    // print('didPopNext route: $route');
  }

  @override
  void didPush() async {
    //pushed to home
    // final route = ModalRoute.of(context).settings.name;
    // print('didPush route: $route');
  }

  @override
  void didPushNext() async {
    //pushed from home
    if (globVar.user != null) {
      if ((ModalRoute.of(context).settings.name == '/home' ||
          ModalRoute.of(context).settings.name == '/')) {
        var isFinish = await Users().refreshUser(
            globVar.user.CUST_ID, globVar.auth.corp,
            check_session: true);
        if (isFinish == null) {
          Navigator.pushNamed(context, '/login');
        } else {
          if (globVar.auth.force_change == 'TRUE') {
            await forcePasswordChange(context);
            await Users().refreshUser(globVar.user.CUST_ID, globVar.auth.corp);
          }
          var agreement = await Users().checkAgreement(
              'LEGAL_AGREEMENT', globVar.user.CUST_ID, globVar.auth.corp);
          if (agreement["STATUS"] && agreement["DATA"] != 'y') {
            var result = await agreementDialog(context, agreement);
            if (!(result ?? false)) {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
          }
        }
      }
    }
    // print('didPushNext route: $route');
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  exitAppDialog() async {
    var exit = await showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                Icon(
                  Icons.meeting_room,
                  size: 85,
                ),
                Center(
                    child: Text(
                  "Sudah ingin keluar ?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                )),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        minWidth: 120,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                                color: Color.fromRGBO(64, 64, 222, 1))),
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text(
                          "Tutup",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(width: 15),
                    FlatButton(
                        minWidth: 120,
                        color: Color.fromRGBO(254, 83, 83, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        padding: EdgeInsets.all(10),
                        onPressed: () async {
                          await utils.backupGlobVar();
                          Navigator.pop(context, true);
                        },
                        child: Text(
                          "Keluar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )),
                  ],
                ),
              ],
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color: Colors.transparent)),
              contentPadding: EdgeInsets.all(20),
            ));
    if (exit ?? false) {
      SystemNavigator.pop();
    }
  }

  forcePasswordChange(context) async {
    Map<String, dynamic> passMap;
    final _formPassKey = GlobalKey<FormBuilderState>();
    bool obscure2 = true, obscure3 = true;
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () => Future.value(false),
              child: StatefulBuilder(
                  builder: (context, setState) => SimpleDialog(
                        children: [
                          FormBuilder(
                              key: _formPassKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FormBuilderTextField(
                                      name: "pass",
                                      obscureText: obscure2 ?? true,
                                      validator: (value) =>
                                          value == null || value.isEmpty
                                              ? "Masukkan password baru"
                                              : null,
                                      decoration: InputDecoration(
                                          suffixIcon: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  obscure2 = !obscure2;
                                                });
                                              },
                                              child: Icon((obscure2)
                                                  ? FontAwesomeIcons.eyeSlash
                                                  : FontAwesomeIcons.eye)),
                                          focusedBorder: new OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    64, 64, 222, 1)),
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(15.0),
                                            ),
                                          ),
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(15.0),
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(23),
                                          hintStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w200,
                                              fontStyle: FontStyle.normal),
                                          hintText: "Password baru"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FormBuilderTextField(
                                      name: "confirm",
                                      obscureText: obscure3 ?? true,
                                      decoration: InputDecoration(
                                          suffixIcon: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  obscure3 = !obscure3;
                                                });
                                              },
                                              child: Icon((obscure3)
                                                  ? FontAwesomeIcons.eyeSlash
                                                  : FontAwesomeIcons.eye)),
                                          focusedBorder: new OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    64, 64, 222, 1)),
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(15.0),
                                            ),
                                          ),
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(15.0),
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(23),
                                          hintStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w200,
                                              fontStyle: FontStyle.normal),
                                          hintText: "Konfirmasi password"),
                                      validator: (value) =>
                                          value == null || value.isEmpty
                                              ? "Masukkan password baru"
                                              : null,
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(width: 15),
                              FlatButton(
                                  minWidth: 120,
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  padding: EdgeInsets.all(10),
                                  onPressed: () async {
                                    _formPassKey.currentState.save();
                                    if (_formPassKey.currentState.validate()) {
                                      if (_formPassKey
                                              .currentState.value["pass"]
                                              .trim() ==
                                          _formPassKey
                                              .currentState.value["confirm"]
                                              .trim()) {
                                        passMap = Map<String, dynamic>.from(
                                            _formPassKey.currentState.value);
                                        passMap.remove("confirm");
                                        for (var i = 0;
                                            i < passMap.keys.length;
                                            i++) {
                                          passMap.update(
                                              passMap.keys.toList()[i],
                                              (value) => value.trim());
                                        }
                                        passMap["check_old"] = 'FALSE';
                                        passMap["login_id"] =
                                            globVar.auth.login_id;
                                        Future future =
                                            Auths().changePass(passMap);
                                        var res = await utils.showLoadingFuture(
                                            context, future);
                                        utils.toast(res["DATA"],
                                            type: (res["STATUS"])
                                                ? "REGULAR"
                                                : "ERROR");
                                        if (res["STATUS"]) {
                                          Navigator.pop(context);
                                        }
                                      } else {
                                        utils.toast("Password baru tidak sama",
                                            type: "ERROR");
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Change",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                        ],
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.transparent)),
                        contentPadding: EdgeInsets.all(20),
                      )),
            ));
  }

  Widget header() {
    return //Header
        Container(
            child: Stack(
      children: [
        Positioned.fill(child: Container(color: Color.fromRGBO(0, 0, 52, 1))),
        Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 18, left: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      (globVar.user.MEMBERSHIP ?? "MyThamrin Club").length > 30
                          ? (globVar.user.MEMBERSHIP ?? "MyThamrin Club")
                              .substring(0, 29)
                          : (globVar.user.MEMBERSHIP ?? "MyThamrin Club"),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await utils.genQRcode(
                          context, globVar.user.CUST_ID.toString());
                    },
                    child: Container(
                      child: Icon(
                        Icons.qr_code_scanner_sharp,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding:
                            const EdgeInsets.only(top: 15, right: 18, left: 18),
                        child: Row(
                          children: [
                            Text(
                              "Hi ",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "${globVar.user != null ? globVar.user.NAME : ""},",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        )),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, right: 18, left: 18),
                      child: Container(
                        child: Text(
                          "Kamu punya \t:",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, right: 18, left: 18),
                  child: Container(
                    height: 30,
                    width: 120,
                    child: FittedBox(
                      child: (globVar.user.MEMBERSHIP_IMAGE == null)
                          ? Image.asset(
                              "images/ThamrinfullBlack.png",
                              filterQuality: FilterQuality.high,
                              colorBlendMode: BlendMode.clear,
                            )
                          : Image(
                              height: 18,
                              gaplessPlayback: true,
                              // width: 60,
                              fit: BoxFit.fitWidth,
                              // errorBuilder: (context,error,stackTrace)=>Icon(FontAwesomeIcons.solidImage,size: 18,color: Colors.white,),
                              // image: NetworkImage(globVar.hostRest+"/binary/${globVar.user.LOYALTY_LEVEL_PHOTO}",headers: {"Authorization":"bearer ${globVar.tokenRest.token}"}),
                              image: MemoryImage(globVar.user.MEMBERSHIP_IMAGE),
                            ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 18, left: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          height: 25,
                          width: 25,
                          child: FittedBox(
                            child: Image.asset(
                              "images/thamrin.png",
                              filterQuality: FilterQuality.high,
                              colorBlendMode: BlendMode.clear,
                            ),
                            fit: BoxFit.fill,
                          )),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Points : ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                        child: Text(
                            "${utils.thousandSeperator(globVar.user.CUST_POINT ?? '')}",
                            style: GoogleFonts.ptMono(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(FontAwesomeIcons.coins,
                            size: 18, color: Colors.amberAccent),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Text(
                          "Level \t: ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${globVar.user.LOYALTY_LEVEL ?? ''}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              fontFamily: "PT_Mono"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: (globVar.user.LOYALTY_LEVEL_IMAGE == null)
                            ? Icon(
                                FontAwesomeIcons.solidImage,
                                size: 18,
                                color: Colors.white,
                              )
                            : Image(
                                height: 12.07,
                                fit: BoxFit.fitHeight,
                                gaplessPlayback: true,
                                // errorBuilder: (context,error,stackTrace)=>Icon(FontAwesomeIcons.solidImage,size: 18,color: Colors.white,),
                                // image: NetworkImage(globVar.hostRest+"/binary/${globVar.user.LOYALTY_LEVEL_PHOTO}",headers: {"Authorization":"bearer ${globVar.tokenRest.token}"}),
                                image: MemoryImage(
                                    globVar.user.LOYALTY_LEVEL_IMAGE),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    ));
  }

  void initialization() async {
    try {
      setState(() {
        globVar.isLoading = true;
      });
      var isFinish = await Users().refreshUser(
          globVar.user.CUST_ID, globVar.auth.corp,
          check_session: true);
      if (isFinish == null) {
        Navigator.pushNamed(context, '/login');
      } else {
        if (globVar.auth.force_change == 'TRUE') {
          await forcePasswordChange(context);
          isFinish = await Users()
              .refreshUser(globVar.user.CUST_ID, globVar.auth.corp);
        }
        if (!isFinish) throw ("Failed refreshing user data");
        var agreement = await Users().checkAgreement(
            'LEGAL_AGREEMENT', globVar.user.CUST_ID, globVar.auth.corp);
        if (agreement["STATUS"] && agreement["DATA"] != 'y') {
          var result = await agreementDialog(context, agreement);
          if (result ?? false) {
            await loadVoucher();
            await loadAvailableVoucher();
            await loadNews();
            await loadMerchants();
            await loadCS();
            await loadFAQ();
            await loadBanners();
          } else {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
        } else {
          await loadVoucher();
          await loadAvailableVoucher();
          await loadNews();
          await loadMerchants();
          await loadCS();
          await loadFAQ();
          await loadBanners();
        }
      }
    } catch (e) {
      utils.toast("Error dalam memperbarui data. Cek koneksi internet.",
          type: 'ERROR');
      print(e);
      setState(() {
        globVar.isLoading = false;
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initialization();
    });
    super.initState();
  }

  loadAvailableVoucher() async {
    var res = await Vouchers().getAvailableList();
    if (res["STATUS"] == 1) {
      voucherList.clear();
      for (var i = 0; i < res["DATA"].length; i++) {
        voucherList.add(Voucher.fromJson(res["DATA"][i]));
      }
      setState(() {});
    } else {
      throw ('Error fetching available vouchers!');
    }
  }

  loadBanners({dontWait: false}) async {
    var res = await ContentApi().getContents("PROMOTIONS");
    if (res["STATUS"] == 1) {
      BannerList.clear();
      for (var i = 0; i < res["DATA"].length; i++) {
        BannerList.add(Content.fromJson(res["DATA"][i]));
      }
      setState(() {
        myVoucherFocus = 0;
        availVoucherFocus = 0;
        bannerFocus = 0;
        if(!dontWait)globVar.isLoading = false;
      });
    } else {
      throw ('Error fetching banners!');
    }
  }

  loadNews() async {
    var res = await ContentApi().getContents("NEWS");
    if (res["STATUS"] == 1) {
      NewsList.clear();
      for (var i = 0; i < res["DATA"].length; i++) {
        NewsList.add(Content.fromJson(res["DATA"][i]));
      }
    } else {
      throw ('Error fetching news!');
    }
  }

  loadCS() async {
    var res = await ContentApi().getContents("CUSTOMER_SERVICE");
    if (res["STATUS"] == 1) {
      CSList.clear();
      for (var i = 0; i < res["DATA"].length; i++) {
        CSList.add(Content.fromJson(res["DATA"][i]));
      }
    } else {
      throw ('Error fetching CS!');
    }
  }

  loadFAQ() async {
    var res = await ContentApi().getContents("FAQ");
    if (res["STATUS"] == 1) {
      FAQList.clear();
      for (var i = 0; i < res["DATA"].length; i++) {
        FAQList.add(Content.fromJson(res["DATA"][i]));
      }
    } else {
      throw ('Error fetching FAQ!');
    }
  }

  loadMerchants() async {
    var res = await ContentApi().getContents("MERCHANT");
    if (res["STATUS"] == 1) {
      MerchantList.clear();
      for (var i = 0; i < res["DATA"].length; i++) {
        MerchantList.add(Content.fromJson(res["DATA"][i]));
      }
    } else {
      throw ('Error fetching merchants!');
    }
  }

  loadVoucher() async {
    var res = await Vouchers().getMyVoucherList();
    if (res["STATUS"] == 1) {
      List<MyVoucher> myVoucherList = [];
      for (var i = 0; i < res["DATA"].length; i++) {
        myVoucherList.add(MyVoucher.fromJson(res["DATA"][i]));
      }
      globVar.myVouchers = myVoucherList;
    } else {
      throw ('Error mengambil data myvouchers!');
    }
  }

  void _onRefresh() async {
    print("refreshing");
    try {
      setState(() {
        globVar.isLoading = true;
      });
      // await Future.delayed(Duration(milliseconds: 1000));
      var isFinish = await Users().refreshUser(
          globVar.user.CUST_ID, globVar.auth.corp,
          check_session: true);
      if (isFinish == null)
        Navigator.pushNamed(context, '/login');
      else {
        if (!isFinish) throw ("Failed refreshing user data");
        await loadVoucher();
        await loadAvailableVoucher();
        await loadNews();
        await loadMerchants();
        await loadCS();
        await loadFAQ();
        await loadBanners();
      }
      _refreshController.refreshCompleted();
    } catch (e) {
      print("error ${e}");
      setState(() {
        globVar.isLoading = false;
      });
      _refreshController.refreshCompleted();
    }
  }
}
