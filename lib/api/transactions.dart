import "../main.dart";
import '../DataType/user.dart';

class Trans{
  getList()async {
    var res = await utils.post(
        // {"cust_id": globVar.user.CUST_ID, "corp": globVar.user.CORP},
        {"cust_id": 1825, "corp": 'TBG'},
        globVar.hostRest + "/transaction/", secure: true, many: true);
    return res;
  }
}