import 'dart:io';
import "../main.dart";
import '../DataType/user.dart';

class Users{
  refreshUser(cust_id,corp)async{
    var res = await utils.post({"cust_id":cust_id,"corp":corp},globVar.hostRest+"/customer/",secure: true);
    if(res["STATUS"]!=1){
      return false;
    }
    globVar.user = User.fromJson(res["DATA"][0]);
    utils.backupGlobVar();
    return true;
  }
  update (Map<String,dynamic> user)async{
    try{
      var res = await utils.put(user, globVar.hostRest+"/customer/update",secure: true);
      await refreshUser(user['cust_id'],globVar.auth.corp);
      return {"STATUS":res["STATUS"]==1,"DATA":res["DATA"]};
    }
    catch(e){
      print(e);
      return {"STATUS":false,"DATA":"Gagal menghubungi server. ${e}."};
    }
  }

  checkAgreement(String agreement,cust_id,corp) async {
    var res = await utils.post({"agreement":agreement,"cust_id":cust_id,"corp":corp},globVar.hostRest+"/customer/agreement",secure: true);
    if(res["STATUS"]!=1){
      return {"STATUS":false,"DATA":"Gagal menghubungi server."};
    }
    return {"STATUS":true,"DATA":res["DATA"]};
  }

  updateAgreement(String agreement,value,cust_id,corp) async {
    var res = await utils.put({"value":value,"agreement":agreement,"cust_id":cust_id,"corp":corp},globVar.hostRest+"/customer/agreement",secure: true);
    if(res["STATUS"]!=1){
      return {"STATUS":false,"DATA":res["DATA"]};
    }
    return {"STATUS":true,"DATA":res["DATA"]};
  }

  updateDP(File image)async{
    var res = await utils.postImage(image,globVar.hostRest+"/customer/changeDP",secure: true,customHeader: {
      "custId":globVar.user.CUST_ID,
      "corp":globVar.auth.corp,
      "title":image.path.substring(image.path.lastIndexOf('/')+1),
    });
    if(res["STATUS"]!=1){
      return {"STATUS":false,"DATA":res["DATA"]};
    }
    await refreshUser(globVar.user.CUST_ID, globVar.auth.corp);
    return {"STATUS":true,"DATA":res["DATA"]};
  }
}