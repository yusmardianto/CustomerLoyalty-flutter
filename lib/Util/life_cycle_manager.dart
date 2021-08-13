import 'package:flutter/material.dart';
import 'package:my_thamrin_club/api/users.dart';
import 'package:flutter/widgets.dart';
import '../main.dart';
class LifeCycleManager extends StatefulWidget {
  final Widget child;
  LifeCycleManager({Key key, this.child}) : super(key: key);
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}
class _LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('state = $state');
    if(state == AppLifecycleState.detached){
      await utils.backupGlobVar();
    }
    else if(state == AppLifecycleState.paused){
      await utils.backupGlobVar();
    }
    else if(state == AppLifecycleState.resumed){
      // await utils.removeBackupGlobVar();
      if(globVar!=null && globVar.user!=null) {
        await Users().refreshUser(globVar.user.CUST_ID, globVar.auth.corp);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}