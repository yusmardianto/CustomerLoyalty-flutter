import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import '../main.dart';
import '../DataType/rest.dart';
import '../DataType/user.dart';
import '../DataType/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../CustomWidget/custom_stateful.dart';

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
  post(Map jsonData, String url,{secure:false,timeout:false,second:10,many=false}) async{
    const JsonDecoder decoder = const JsonDecoder();
    try {
      var headers = {'Content-type': 'application/json'};

      if(secure) {
        await tokenFetch();
        headers["Authorization"] =
            "bearer ${globVar.tokenRest.token}";
      }
      Future<http.Response> futureResponse = http.post(
          '$url', headers: headers,
          body: json.encode(jsonData));;
      if (timeout)
        futureResponse.timeout(
            Duration(seconds: second));
      http.Response response = await Future.sync(() => futureResponse);
      if(htmlErrorTitle(response.body.toString())!=""){
        return {"STATUS":(response.statusCode != 200)?0:1,"DATA":htmlErrorTitle(response.body.toString())};
      }
      else{
        final Map data = decoder.convert(response.body);
        if(data["STATUS"]==200){
          var res;
          try{
            res =  decoder.convert(data["DATA"]);
          }catch(e){
            res = data["DATA"];
          }
          return {"STATUS":1,"DATA":res};
        }
        else{
          return {"STATUS":0,"DATA":data["ERROR"]};
        }
      }
    } on TimeoutException catch(e){
      return {"STATUS":0,"DATA":"Request Timeout"};
    }
    on Exception catch(exception){
      print([url,exception]);
//      Toast("Not Connected to Server", Colors.red);
      return {"STATUS":0,"DATA":"Not Connected to Server"};
    }
  }
  put(Map jsonData, String url,{secure:false,timeout:false,second:10}) async{
    const JsonDecoder decoder = const JsonDecoder();
    try {
      var headers = {'Content-type': 'application/json'};

      if(secure) {
        await tokenFetch();
        headers["Authorization"] =
        "bearer ${globVar.tokenRest.token}";
      }
      Future<http.Response> futureResponse = http.put(
          '$url', headers: headers,
          body: json.encode(jsonData));;
      if (timeout)
        futureResponse.timeout(
            Duration(seconds: second));
      http.Response response = await Future.sync(() => futureResponse);
      print(response.body.toString());
      if(htmlErrorTitle(response.body.toString())!=""){
        return {"STATUS":(response.statusCode != 200)?0:1,"DATA":htmlErrorTitle(response.body.toString())};
      }
      else{
        final Map data = decoder.convert(response.body);
        if(data["STATUS"]==200){
          var res;
          try{
            res =  decoder.convert(data["DATA"]);
          }catch(e){
            res = data["DATA"];
          }
          return {"STATUS":1,"DATA":res};
        }
        else{
          return {"STATUS":0,"DATA":data["ERROR"]};
        }
      }
    }
    on TimeoutException catch(e){
      return {"STATUS":0,"DATA":"Request Timeout"};
    }
    on SocketException catch(e){
      // print([url,exception]);
//      Toast("Not Connected to Server", Colors.red);
      return {"STATUS":0,"DATA":"Not Connected to Server"};
    }
  }
  get(String url,{secure:false,timeout:false,second:10}) async{
    const JsonDecoder decoder = const JsonDecoder();
    try {
      var headers = {'Content-type': 'application/json'};
      if(secure) {
        await tokenFetch();
        headers["Authorization"] =
            "bearer ${globVar.tokenRest.token}";
      }
      Future<http.Response> futureResponse = http.get(
          '$url', headers: headers);
      if (timeout)
        futureResponse.timeout(
            Duration(seconds: second));
      http.Response response = await Future.sync(() => futureResponse);
      if(htmlErrorTitle(response.body.toString())!=""){
        return {"STATUS":(response.statusCode != 200)?0:1,"DATA":htmlErrorTitle(response.body.toString())};
      }
      else{
        final Map res = decoder.convert(response.body);
        return {"STATUS":(response.statusCode != 200)?0:1,"DATA":res};
      }
    } on TimeoutException catch(e){
      return {"STATUS":0,"DATA":"Request Timeout"};
    }
    on Exception catch(exception){
      print([url,exception]);
      return {"STATUS":0,"DATA":"Not Connected to Server"};
    }
  }
  htmlErrorTitle(String html){
    try{
      String titleElement = html.substring(html.indexOf("<title>"),html.indexOf("<\/title>"));
      return titleElement;
    }
    catch(e){
      return '';
    }
  }
  backupGlobVar()async{
    await prefs.setString("token", JsonEncoder().convert(globVar.tokenRest.toJson()));
    if(globVar.auth!=null) await prefs.setString("auth", JsonEncoder().convert(globVar.auth.toJson()));
    if(globVar.user!=null) await prefs.setString("user", JsonEncoder().convert(globVar.user.toJson()));
  }
  restoreGlobVar()async{
    if(prefs.getString("token")!=null){
      print("restore token");
      globVar.tokenRest = Rest.fromJson(JsonDecoder().convert(prefs.getString("token")));
    }
    if(prefs.getString("user")!=null){
      print("restore user");
      globVar.user = User.fromJson(JsonDecoder().convert(prefs.getString("user")));
    }
    if(prefs.getString("auth")!=null){
      print("restore auth");
      globVar.auth = Auth.fromJson(JsonDecoder().convert(prefs.getString("auth")));
    }
  }
  removeBackupGlobVar()async{
    print("clear prefs");
    // prefs.remove("token");
    await prefs.remove("user");
    await prefs.remove("auth");
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
  showLoadingFuture(context,future,{dismiss=false,onWillPop})async {
    var dialogContext;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        dialogContext = context;
        return WillPopScope(
          onWillPop: onWillPop??()async{return true;},
          child: new Center(
            child: new CircularProgressIndicator(),
          ),
        );
      },
      barrierDismissible: dismiss,
    );
    var res = await future;
    Navigator.pop(dialogContext);
    return res;
  }
  leadingZero(num, size){     return ('000000000' + num.toString()).substring(('000000000' + num.toString()).length-size); }
  genBarcode(context,code,expired) {
    int countDown = expired;
    Timer timer_;
    try{
      showDialog(
          context: context,
        builder: (context){
            return CustomStatefulBuilder(
              dispose: (){
                timer_?.cancel();
              },
              builder: (context,setState){
                if(timer_==null||!timer_.isActive){
                  timer_ = new Timer.periodic(Duration(seconds: 1),(timer){
                    setState((){
                      countDown=countDown-1;
                    });
                    if(countDown<=0){
                      timer.cancel();
                      Navigator.pop(context);
                    }
                  });
                }
                return SimpleDialog(
                  contentPadding: EdgeInsets.all(20) ,
                  children: [
                    Center(child: Text('Barcode berikut berlaku dalam')),
                    SizedBox(height: 25,),
                    Center(child: Text('${Duration(seconds: countDown).inMinutes}:${leadingZero(Duration(seconds: countDown-(Duration(seconds: countDown).inMinutes*60)).inSeconds,2)}',style: GoogleFonts.robotoMono(fontWeight: FontWeight.w700,fontSize: 18),)),
                    SizedBox(height: 25,),
                    (code==null)?Container(height: 75,child: Center(child: Text('Code tidak valid')),):SvgPicture.string(Barcode.code128().toSvg(code, width: 200, height: 75,drawText: false)),
                    SizedBox(height: 15,),
                    (code==null)?Container():Center(child: Text(code,style: GoogleFonts.robotoCondensed(fontSize: 21),)),
                  ],
                );
              },
            );
        }
      );
    }
    catch(e){
      print(e);
    }
  }
}
