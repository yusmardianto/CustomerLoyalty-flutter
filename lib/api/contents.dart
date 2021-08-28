import '../main.dart';

class News{
  getNews(String news)async{
    var res = await utils.post(
        {
          "corp": globVar.auth.corp,
          "cust_id": globVar.user.CUST_ID,
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