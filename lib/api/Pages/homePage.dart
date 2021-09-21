import '../../main.dart';

class HomeApi{
  getAllSections()async{
    var res = await utils.post(
        {
          "cust_id": (globVar.user==null)?null:globVar.user.CUST_ID,
          "corp": (globVar.auth==null)?null:globVar.auth.corp,
          "type": "PROMOTIONS,NEWS,MERCHANT,FAQ,CUSTOMER_SERVICE"
        },
        globVar.hostRest + "/page/homepage",
        secure: true, many: true);
    return res;
  }
}