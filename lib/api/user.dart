import "../main.dart";
import '../DataType/user.dart';

class Users{
  saveUser(cust_id)async{
    var res = await utils.get(globVar.hostRest+"/customer/$cust_id",secure: true);
    if(res["STATUS"]!=1){
      return false;
    }
    globVar.user = User.fromJson(res["DATA"]);
    utils.backupGlobVar();
    return true;
  }
  update (Map<String,dynamic> user)async{
    try{
      var res = await utils.put(user, globVar.hostRest+"/customer/update",secure: true);
      await saveUser(user['cust_id']);
      return {"STATUS":res["STATUS"]==1,"DATA":res["DATA"]};
    }
    catch(e){
      print(e);
      return {"STATUS":false,"DATA":"Gagal menghubungi server. ${e}."};
    }
  }
}