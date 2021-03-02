import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import '../main.dart';

class Util{
  tokenFetch() async {
    if((globVar.tokenExpire != null && DateTime.now().isBefore(globVar.tokenExpire))||globVar.tokenRest==null){
      final tokenEndpoint = Uri.parse('https://loyalty.thamrin.xyz/ords/loyalty/oauth/token');
      var clients =  JsonDecoder().convert(globVar.prefs.getString("clientCred"));
      oauth2.Client grant = await oauth2.clientCredentialsGrant(tokenEndpoint, clients["id"], clients["secret"]);
      globVar.tokenExpire=grant.credentials.expiration;
      globVar.tokenRest=grant.credentials.accessToken;
    }
  }
  Post(Map jsonData, String url,{secure:false,timeout:false,second:10}) async{
    const JsonDecoder decoder = const JsonDecoder();
    try {
      var headers = {'Content-type': 'application/json'};
      if(secure) {
        await tokenFetch();
        headers["Authorization"] =
            "bearer ${globVar.prefs.getString("tokenRest")}";
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
      return {"STATUS":1,"DATA":data};
    } on TimeoutException catch(e){
      return {"STATUS":"0","DATA":"Request Timeout"};
    }
    on Exception catch(exception){
      print([url,exception]);
//      Toast("Not Connected to Server", Colors.red);
      return {"STATUS":"ERROR","DATA":"Not Connected to Server"};
    }
  }
  Get(String url,{secure:false,timeout:false,second:10}) async{
    const JsonDecoder decoder = const JsonDecoder();
    try {
      var headers = {'Content-type': 'application/json'};
      if(secure) {
        await tokenFetch();
        headers["Authorization"] =
            "bearer ${globVar.prefs.getString("tokenRest")}";
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
}