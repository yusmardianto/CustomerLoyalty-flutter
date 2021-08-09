import 'package:flutter/material.dart';
import 'package:my_thamrin_club/api/users.dart';

import '../main.dart';

class MiddleWare extends StatefulWidget {
  const MiddleWare(
      {@required this.child, Key key})
      : super(key: key);

  final Widget child;

  static _MiddleWareState of(BuildContext context) =>
      context.findAncestorStateOfType<_MiddleWareState>();

  @override
  _MiddleWareState createState() => _MiddleWareState();
}

class _MiddleWareState extends State<MiddleWare> {
  Future<T> pushConditionally<T extends Object>(
      BuildContext context, Route<T> route){

      return Users().checkAgreement('LEGAL_AGREEMENT', globVar.user.CUST_ID, globVar.auth.corp).then((agreement)=>
        (agreement["STATUS"]&&agreement["DATA"]!='y')
            ? Navigator.pushNamed(context, '/home')
            : Navigator.push(context,route)
      );

  }

  Future<T> pushConditionallyNamed<T extends Object>(
      BuildContext context,
      String routeName, {
        Object arguments,
      }){
      return Users().checkAgreement('LEGAL_AGREEMENT', globVar.user.CUST_ID, globVar.auth.corp).then((agreement)=>
      (agreement["STATUS"]&&agreement["DATA"]!='y')
          ? Navigator.pushNamed(context, '/home')
          : Navigator.pushNamed(context,routeName,arguments:arguments)
      );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}