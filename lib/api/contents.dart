import '../main.dart';

class ContentApi{
  getContents(String news)async{
    var res = await utils.post(
        {
          "corp": (globVar.auth==null)?null:globVar.auth.corp,
          "cust_id": (globVar.user==null)?null:globVar.user.CUST_ID,
          "type": news,
        },
        globVar.hostRest + "/contents/", secure: true, many: true);
    // print("res ${{
    //   "corp": globVar.auth.corp,
    //   "cust_id": globVar.user.CUST_ID,
    //   "type": news,
    // }}");
    return res;
  }
}