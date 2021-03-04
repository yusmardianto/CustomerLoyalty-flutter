import "../main.dart";
import "dart:convert";
import '../DataType/user.dart';
class Auth{
  login (user,pass)async{
    try{
      var res = await utils.post({"user":user,"pass":pass}, globVar.hostRest+"/auth/",secure: true);
      if(res["STATUS"]==1){
        var json = res["DATA"];
        if(json["STATUS"]=="OK"){
          res = await utils.get(globVar.hostRest+"/customer/${json["G_CUST_ID"]}",secure: true);
          if(res["STATUS"]!=1){
            return {"STATUS":false,"DATA":"Gagal menghubungi server. Silakan mengecek internet anda."};
          }

          res["DATA"]["login_id"] = json["LOGIN_ID"];
          res["DATA"]["force_change"] = json["FORCE_CHANGE_PASSWD"];
          res["DATA"]["user_type"] = json["TIPE_USER"];
          globVar.user = User.fromJson(res["DATA"]);
          utils.backupGlobVar();
        }
        return {"STATUS":json["STATUS"]=="OK","DATA":json["LOGIN_MESSAGE"]};
      }
      else{
        return {"STATUS":false,"DATA":"Gagal menghubungi server. Silakan mengecek internet anda."};
      }
    }
    catch(e){
      print(e);
      return {"STATUS":false,"DATA":"Gagal menghubungi server. ${e}."};
    }
  }
}