import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import '../main.dart';

class Util{
  tokenFetch() async {
    final tokenEndpoint = Uri.parse('https://loyalty.thamrin.xyz/ords/loyalty/oauth/token');
    var clients =  globVar.clientRest;
    oauth2.Client grant = await oauth2.clientCredentialsGrant(tokenEndpoint, clients["id"], clients["secret"]);
    print(grant.credentials.accessToken);
  }
  Post(Map jsonData, String url,{timeout:false,second:10}) async{
    const JsonDecoder decoder = const JsonDecoder();
    try {
      http.Response response;
      if (timeout)
        response = await http.post(
            '$url', headers: {'Content-type': 'application/json'},
            body: json.encode(jsonData)).timeout(
            Duration(seconds: second));
      else
        response = await http.post(
            '$url', headers: {'Content-type': 'application/json'},
            body: json.encode(jsonData));
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
  Get(String url,{timeout:false,second:10}) async{
    const JsonDecoder decoder = const JsonDecoder();
    try {
      http.Response response;
      if (timeout)
        response = await http.get(
            '$url', headers: {'Authorization': 'bearer 3eYXmkaWwlePiHwyzasqgg'}).timeout(
            Duration(seconds: second));
      else
        response = await http.get(
            '$url', headers: {'Authorization': 'bearer 3eYXmkaWwlePiHwyzasqgg'});
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