import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'DataType/news.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'main.dart';

class News extends StatefulWidget {
  final NewsBanner news;
  News(this.news);
  // News({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.04,),
            Container(
              padding: EdgeInsets.only(top: 10,right: 10),
              alignment: Alignment.centerRight,
              height: 24,
              child: Text(DateFormat('dd MMM yyyy').format(widget.news.date),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Color.fromRGBO(154,154,154,1)),),
            ),
            Container(
              padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 20),
              child: Text(widget.news.title,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24,),),
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
                      image: MemoryImage(widget.news.message_image),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(widget.news.short_title,style: TextStyle(color: Color.fromRGBO(82,75,75,1),fontSize: 18,fontWeight: FontWeight.w700),),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: HtmlWidget(
                        utils.htmlEscape(widget.news.message_body)??'',
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
    );
  }
}