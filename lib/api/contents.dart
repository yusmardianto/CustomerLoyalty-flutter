import '../main.dart';

class ContentApi{
  getContents(String news)async{
    var res = await utils.post(
        {
          "corp": (globVar.auth==null)?null:globVar.auth.corp,
          "cust_id": (globVar.user==null)?null:globVar.user.CUST_ID,
          "type": news,
          "dataOnly":'TRUE',
        },
        globVar.hostRest + "/contents/",
        secure: true, many: true);
    return res;
  }

  getAllContents()async{
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