import "../main.dart";
import '../DataType/user.dart';

class Users{
  saveUser(cust_id,corp)async{
    var res = await utils.post({"cust_id":cust_id,"corp":corp},globVar.hostRest+"/customer/",secure: true,many: true);
    if(res["STATUS"]!=1){
      return false;
    }
    // print(res);
    globVar.user = User.fromJson(res["DATA"][0]);
    utils.backupGlobVar();
    return true;
  }
  update (Map<String,dynamic> user)async{
    try{
      print("test $user");
      var res = await utils.put(user, globVar.hostRest+"/customer/update",secure: true);
      await saveUser(user['cust_id'],globVar.auth.corp);
      return {"STATUS":res["STATUS"]==1,"DATA":res["DATA"]};
    }
    catch(e){
      print(e);
      return {"STATUS":false,"DATA":"Gagal menghubungi server. ${e}."};
    }
  }
}