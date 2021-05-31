import '../main.dart';

class News{
  getNews(String news)async{
    var res = await utils.post(
        {
          "corp": globVar.auth.corp,
          "type": news,
        },
        globVar.hostRest + "/contents/", secure: true, many: true);
    // print("res ${globVar.hostRest + "/news/"}");
    return res;
  }
}