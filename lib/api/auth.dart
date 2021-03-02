import "../main.dart";
import "dart:convert";
class Auth{
  login (user,pass)async{
    var res = await utils.Post({"user":user,"pass":pass}, globVar.hostRest+"/auth/",secure: true);
    if(res["STATUS"]==1){
      print("SUKSES");
    }
    else{
      print("GAGAL");
    }
    print(res);
  }
}