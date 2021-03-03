import "../main.dart";
import "dart:convert";
import '../DataType/user.dart';
class Auth{
  login (user,pass)async{
    var res = await utils.post({"user":user,"pass":pass}, globVar.hostRest+"/auth/",secure: true);
    if(res["STATUS"]==1){
      var json = res["DATA"];
      globVar.user = User(json["LOGIN_ID"], json["USERNAME"], json["G_CORP_NAME"], json["G_LOYALTY_CUST_ID"], json["FORCE_CHANGE_PASSWD"],json["TIPE_USER"]);
      return {"STATUS":json["STATUS"]=="OK","DATA":json["LOGIN_MESSAGE"]};
    }
    else{
      return {"STATUS":false,"DATA":"Gagal menghubungi server. Silakan mengecek internet anda."};
    }
  }
}