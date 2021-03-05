import "../main.dart";
import '../DataType/user.dart';
import '../DataType/auth.dart';
import 'user.dart';
class Auths{
  login (user,pass)async{
    try{
      var res = await utils.post({"user":user,"pass":pass}, globVar.hostRest+"/auth/",secure: true);
      if(res["STATUS"]==1){
        var json = res["DATA"];
        globVar.auth = Auth.fromJson(json);
        if(json["STATUS"]=="OK"){
          var fetchUser = await Users().saveUser(json["G_CUST_ID"]);
          if(!fetchUser){
            return {"STATUS":false,"DATA":"Gagal menghubungi server. Silakan mengecek internet anda."};
          }
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
  register (Map<String,dynamic> user)async{
    try{
      var res = await utils.put(user, globVar.hostRest+"/customer/register",secure: true);
        return {"STATUS":res["STATUS"]==1,"DATA":res["DATA"]};
    }
    catch(e){
      print(e);
      return {"STATUS":false,"DATA":"Gagal menghubungi server. ${e}."};
    }
  }
}