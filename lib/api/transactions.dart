import 'package:intl/intl.dart';

import "../main.dart";
import '../DataType/user.dart';

class Trans{
  getList(start_date,end_date)async {
    var res = await utils.post(
        {
          "cust_id": globVar.user.CUST_ID,
          "corp": globVar.auth.corp,
          "start_date":start_date??"01-Jan-2021",
          "end_date":end_date??"31-Jan-2021"
        },
        globVar.hostRest + "/transaction/", secure: true, many: true);
    return res;
  }
}