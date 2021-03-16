import 'package:intl/intl.dart';

import "../main.dart";
import '../DataType/voucher.dart';

class Vouchers{
  getAvailableList()async {
    var res = await utils.post(
        // {"cust_id": globVar.user.CUST_ID, "corp": globVar.user.CORP},
        {
          "corp": globVar.auth.corp,
        },
        globVar.hostRest + "/voucher/", secure: true, many: true);
    return res;
  }

  getMyVoucherList()async {
    var res = await utils.post(
      // {"cust_id": globVar.user.CUST_ID, "corp": globVar.user.CORP},
        {
          "corp": globVar.auth.corp,
          "cust_id" : 1825
        },
        globVar.hostRest + "/voucher/redeemed", secure: true, many: true);
    return res;
  }

  redeem(voucher_id)async {
    try{
    var res = await utils.put(
      // {"cust_id": globVar.user.CUST_ID, "corp": globVar.user.CORP},
        {
          "corp": globVar.auth.corp,
          "cust_id": globVar.user.CUST_ID,
          "voucher_id":voucher_id
        },
        globVar.hostRest + "/voucher/redeem", secure: true);
    return {"STATUS":res["STATUS"]==1,"DATA":res["DATA"]};
    }
    catch(e){
      print(e);
      return {"STATUS":false,"DATA":"Gagal menghubungi server. ${e}."};
    }
  }
}