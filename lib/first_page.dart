import 'package:flutter/material.dart';
import 'CustomShape/circle_tab_indicator.dart';
import 'DataType/contents.dart';
import 'main.dart';

class FirstPage extends StatefulWidget {
  final List<Content> features;
  FirstPage(this.features);
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {;
    _controller = TabController(length: widget.features.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                                children: widget.features.map((i) => Container(
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
                              tabs: widget.features.map((i)=>Container(
                                width: 13,
                                height: 13,
                              )).toList(),
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
                children: widget.features.map((e) => Container(
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
                      (widget.features.last==e)
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
              ),
            ),
          ],
        ),
      );
  }
}