import 'package:flutter/material.dart';
import 'CustomShape/multi_shaper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class VouchersList extends StatefulWidget {
  VouchersList({Key key}) : super(key: key);

  @override
  _VouchersListState createState() => _VouchersListState();
}

class _VouchersListState extends State<VouchersList> {
  final search = new TextEditingController();
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
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: MulltiPainter(),
              ),
            ),
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
                        hintStyle: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.italic,fontSize: 18),
                      ),
                      style: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.italic,fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}