import '../main.dart';

class News{
  getNews()async{
    var res = await utils.post(
        {
          "corp": globVar.auth.corp,
        },
        globVar.hostRest + "/news/", secure: true, many: true);
    // print("res $res");
    return res;
  }
}