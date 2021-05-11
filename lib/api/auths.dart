import 'package:flutter/widgets.dart';

import "../main.dart";
import '../DataType/user.dart';
import '../DataType/auth.dart';
import 'users.dart';
class Auths{
  login (user,pass)async{
    try{
      var res = await utils.post({"user":user,"pass":pass}, globVar.hostRest+"/auth/",secure: true);
      var json = res["DATA"];
      // print("res $json");
      if(res["STATUS"]==1 && json["STATUS"]=="OK"){
        globVar.auth = Auth.fromJson(json);
          var fetchUser = await Users().refreshUser(json["G_CUST_ID"],json["G_CORP"]);
        if(!fetchUser){
            return {"STATUS":false,"DATA":"Gagal menghubungi server. Silakan mengecek internet anda."};
          }
        return {"STATUS":json["STATUS"]=="OK","DATA":json["LOGIN_MESSAGE"]};
      }
      else{
        return {"STATUS":false,"DATA":(res["STATUS"]==1)?res["DATA"]["LOGIN_MESSAGE"]:"Gagal menghubungi server. Silakan mengecek internet anda."};
      }
    }
    catch(e){
      print(e);
      return {"STATUS":false,"DATA":"${e}."};
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
  changePass (Map<String,dynamic> passMap)async{
    try{
      var res = await utils.put(passMap, globVar.hostRest+"/auth/change",secure: true);
      return {"STATUS":res["STATUS"]==1,"DATA":res["DATA"]};
    }
    catch(e){
      print(e);
      return {"STATUS":false,"DATA":"Gagal menghubungi server. ${e}."};
    }
  }
}