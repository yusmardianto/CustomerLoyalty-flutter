import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../DataType/contents.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../main.dart';

class NewsDetail extends StatefulWidget {
  final Content ContentApi;
  NewsDetail(this.ContentApi);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushReplacementNamed(context,"/news");
        return false;
      },
      child: Material(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.04,),
              Container(
                padding: EdgeInsets.only(top: 10,right: 10),
                alignment: Alignment.centerRight,
                height: 24,
                child: Text(DateFormat('dd MMM yyyy').format(widget.ContentApi.date),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Color.fromRGBO(154,154,154,1)),),
              ),
              Container(
                padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 20),
                child: Text(widget.ContentApi.title,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24,),),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        fit: BoxFit.fitWidth,
                        isAntiAlias: true,
                        width: MediaQuery.of(context).size.width,
                        image: MemoryImage(widget.ContentApi.message_image),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(widget.ContentApi.short_title,style: TextStyle(color: Color.fromRGBO(82,75,75,1),fontSize: 18,fontWeight: FontWeight.w700),),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: HtmlWidget(
                          utils.htmlEscape(widget.ContentApi.message_body)??'',
                          onTapUrl: (url)=> utils.launchBrowserURL(url),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}