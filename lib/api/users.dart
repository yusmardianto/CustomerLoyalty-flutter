import 'dart:io';

import 'package:flutter/cupertino.dart';

import "../main.dart";
import '../DataType/user.dart';

class Users{
  refreshUser(cust_id,corp)async{
    var res = await utils.post({"cust_id":cust_id,"corp":corp},globVar.hostRest+"/customer/",secure: true);
    if(res["STATUS"]!=1){
      return false;
    }
    // print("test $res");
    globVar.user = User.fromJson(res["DATA"][0]);
    utils.backupGlobVar();
    // print("current ${ModalRoute.of(navKey.currentContext).settings.name}");
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