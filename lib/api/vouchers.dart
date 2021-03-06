import "../main.dart";

class Vouchers{
  getAvailableList()async {
    var res = await utils.post(
        // {"cust_id": globVar.user.CUST_ID, "corp": globVar.user.CORP},
        {
          "corp": globVar.auth.corp,
          "cust_id" : globVar.user.CUST_ID,
        },
        globVar.hostRest + "/vouchers/", secure: true, many: true);
    print("available $res");
    return res;
  }

  getMyVoucherList()async {
    var res = await utils.post(
        {
          "corp": globVar.auth.corp,
          "cust_id" : globVar.user.CUST_ID
        },
        globVar.hostRest + "/vouchers/redeemed", secure: true, many: true);
    return res;
  }

  voucherDetails(loyalty_campaign_id)async{
    var res = await utils.post(
        {
          "loyalty_campaign_id" : loyalty_campaign_id
        },
        globVar.hostRest + "/voucher/", secure: true, many: true);
    print([loyalty_campaign_id,res]);
    return res;
  }

  redeem(voucher_id)async {
    // print("id $voucher_id");
    try{
    var res = await utils.put(
      // {"cust_id": globVar.user.CUST_ID, "corp": globVar.user.CORP},
        {
          "corp": globVar.auth.corp,
          "cust_id": globVar.user.CUST_ID,
          "voucher_id":voucher_id
        },
        globVar.hostRest + "/voucher/redeem", secure: true);
    // if(res["STATUS"]==1)await Users().refreshUser(globVar.user.CUST_ID,globVar.auth.corp);
    return {"STATUS":res["STATUS"]==1,"DATA":res["DATA"]};
    }
    catch(e){
      print("$e");
      return {"STATUS":false,"DATA":"Gagal menghubungi server. ${e}."};
    }
  }

  useVoucher(voucher_id)async {
    try{
      var res = await utils.post(
        // {"cust_id": globVar.user.CUST_ID, "corp": globVar.user.CORP},
          {
            "corp": globVar.auth.corp,
            "cust_id": globVar.user.CUST_ID,
            "voucher_id":voucher_id
          },
          globVar.hostRest + "/voucher/use", secure: true);

      return {"STATUS":res["STATUS"]==1,"DATA":res["DATA"]};
    }
    catch(e){
      print(e);
      return {"STATUS":false,"DATA":"Gagal menghubungi server. ${e}."};
    }
  }
}