import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import '../main.dart';
import '../DataType/rest.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../DataType/user.dart';


class Util{
  tokenFetch() async {
    if(globVar.tokenRest==null||globVar.tokenRest.token==null||(globVar.tokenRest.expire != null && DateTime.now().isAfter(globVar.tokenRest.expire))){
      final tokenEndpoint = Uri.parse('https://loyalty.thamrin.xyz/ords/loyalty/oauth/token');
      var clients =  JsonDecoder().convert(prefs.getString("clientCred"));
      oauth2.Client grant = await oauth2.clientCredentialsGrant(tokenEndpoint, clients["id"], clients["secret"]);
      globVar.tokenRest=Rest(grant.credentials.accessToken,grant.credentials.expiration);
      await backupGlobVar();
    }
  }
  post(Map jsonData, String url,{secure:false,timeout:false,second:10}) async{
    const JsonDecoder decoder = const JsonDecoder();
    try {
      var headers = {'Content-type': 'application/json'};
      if(secure) {
        await tokenFetch();
        headers["Authorization"] =
            "bearer ${prefs.getString("tokenRest")}";
      }
      Future<http.Response> futureResponse = http.post(
          '$url', headers: headers,
          body: json.encode(jsonData));;
      if (timeout)
        futureResponse.timeout(
            Duration(seconds: second));
      http.Response response = await Future.sync(() => futureResponse);
      if(response.statusCode != 200){
        return {"STATUS":0,"DATA":response.body.toString()};
      }
      final Map data = decoder.convert(response.body);
      return {"STATUS":1,"DATA":decoder.convert(data["res"])};
    } on TimeoutException catch(e){
      return {"STATUS":"0","DATA":"Request Timeout"};
    }
    on Exception catch(exception){
      print([url,exception]);
//      Toast("Not Connected to Server", Colors.red);
      return {"STATUS":"ERROR","DATA":"Not Connected to Server"};
    }
  }
  get(String url,{secure:false,timeout:false,second:10}) async{
    const JsonDecoder decoder = const JsonDecoder();
    try {
      var headers = {'Content-type': 'application/json'};
      if(secure) {
        await tokenFetch();
        headers["Authorization"] =
            "bearer ${prefs.getString("tokenRest")}";
      }
      Future<http.Response> futureResponse = http.get(
          '$url', headers: headers);
      if (timeout)
        futureResponse.timeout(
            Duration(seconds: second));
      http.Response response = await Future.sync(() => futureResponse);
      if(response.statusCode != 200){
        return {"STATUS":0,"DATA":response.body.toString()};
      }
      final Map data = decoder.convert(response.body);
      return {"STATUS":1,"DATA":data};
    } on TimeoutException catch(e){
      return {"STATUS":"0","DATA":"Request Timeout"};
    }
    on Exception catch(exception){
      print([url,exception]);
      return {"STATUS":"ERROR","DATA":"Not Connected to Server"};
    }
  }
  backupGlobVar()async{
    prefs.setString("token", JsonEncoder().convert(globVar.tokenRest.toJson()));
    if(globVar.user!=null)prefs.setString("user", JsonEncoder().convert(globVar.user.toJson()));
  }
  restoreGlobVar()async{
    if(prefs.getString("token")!=null){
      globVar.tokenRest = Rest.fromJson(JsonDecoder().convert(prefs.getString("token")));
    }
    if(prefs.getString("user")!=null){
      globVar.user = User.fromJson(JsonDecoder().convert(prefs.getString("user")));
    }
  }
  removeBackupGlobVar()async{
    prefs.remove("token");
    prefs.remove("user");
  }
  toast(text,{type:"REGULAR"})async{
    await Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: type=="REGULAR"?Colors.grey:Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
