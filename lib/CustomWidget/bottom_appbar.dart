import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_thamrin_club/api/users.dart';

import '../main.dart';

class BottomAppbar extends StatefulWidget {
  // const BottomAppbar({Key key}) : super(key: key);
  final void Function() refresh;
  final int currentPage;
  BottomAppbar(this.refresh,this.currentPage);
  @override
  _BottomAppbarState createState() => _BottomAppbarState();
}

class _BottomAppbarState extends State<BottomAppbar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Container(
          height: 63,
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: (){
                    if(widget.currentPage==1){
                      widget.refresh();
                    }
                    else{
                      Navigator.pushNamed(context, '/home');
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.home,
                      size: 26,
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
                InkWell(
                  onTap: () async {
                    if(widget.currentPage==2){
                      widget.refresh();
                    }
                    else{
                      await Navigator.pushNamed(context, "/transactions");
                      await Users()
                          .refreshUser(globVar.user.CUST_ID, globVar.auth.corp);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(FontAwesomeIcons.receipt, size: 26),
                  ),
                ),
                Container(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
                InkWell(
                  onTap: () async {
                    if(widget.currentPage==3){
                      widget.refresh();
                    }
                    else{
                      await Navigator.pushNamed(context, "/vouchers");
                      await Users()
                          .refreshUser(globVar.user.CUST_ID, globVar.auth.corp);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(FontAwesomeIcons.gift, size: 26),
                  ),
                ),
                Container(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
                InkWell(
                  onTap: () async {
                    if(widget.currentPage==4){
                      widget.refresh();
                    }
                    else{
                      await Navigator.pushNamed(context, "/profile");
                      await Users()
                          .refreshUser(globVar.user.CUST_ID, globVar.auth.corp);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(FontAwesomeIcons.addressCard, size: 24),
                  ),
                ),
              ]),
        ));
  }
}
