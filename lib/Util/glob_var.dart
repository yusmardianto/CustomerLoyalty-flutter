import "package:shared_preferences/shared_preferences.dart";
import 'dart:convert';
import '../DataType/user.dart';
import '../DataType/rest.dart';
import '../main.dart';
class GlobaVar{
  String hostRest = "https://loyalty.thamrin.xyz/ords/loyalty/loyaltymobile";

  //=====================shownotif============================
  bool _isShowNotif;
  bool get isShowNotif => _isShowNotif;
  set isShowNotif(value) => _isShowNotif = value;
  //======================shared_pref=========================
  SharedPreferences _prefs;
  SharedPreferences get prefs => _prefs;
  //======================token && expiration==================
  Rest _tokenRest;
  Rest get tokenRest => _tokenRest;
  set tokenRest(value) => _tokenRest = value;
  //===============user_login_data=============================
  User _user;
  User get user => _user;
  set user(value) => _user = value;
//=============================================================





  //============================================================

  static final GlobaVar _instance = GlobaVar._internal();
  factory GlobaVar() => _instance;

  //init State
  GlobaVar._internal() {
    initGlobVar();
  }
  Future initGlobVar() async {
    _isShowNotif = true;
    _prefs = await SharedPreferences.getInstance();
    if(_prefs.getString("clientCred")==null){
      _prefs.setString("clientCred", json.encode({
        "id": "S1BiT8Wwxgypz7B4DdxZsw..",
        "secret" : "uxj_dNikz8JcvasOd1l3jA.."
      }).toString());
    }
    await utils.restoreGlobVar();
  }
}