import "package:shared_preferences/shared_preferences.dart";
import 'dart:convert';
import '../DataType/user.dart';
import '../DataType/rest.dart';
import '../DataType/auth.dart';
import '../DataType/voucher.dart';
import '../main.dart';
class GlobVar{
  String hostRest = "https://loyalty.thamrin.xyz/ords/loyalty/loyaltymobile";

  //=====================isLoading============================
  bool _isLoading;
  bool get isLoading => _isLoading;
  set isLoading(value) => _isLoading = value;
  //=====================shownotif============================
  bool _isShowNotif;
  bool get isShowNotif => _isShowNotif;
  set isShowNotif(value) => _isShowNotif = value;
  //======================token && expiration==================
  Rest _tokenRest;
  Rest get tokenRest => _tokenRest;
  set tokenRest(value) => _tokenRest = value;
  //===============user_login_data=============================
  User _user;
  User get user => _user;
  set user(value) => _user = value;
//=======================Auth_Data=============================
  Auth _auth;
  Auth get auth => _auth;
  set auth(value) => _auth = value;
  //=====================MyVoucher==============================
  List<MyVoucher> _myVouchers = [];
  List<MyVoucher> get myVouchers => _myVouchers;
  set myVouchers(value) => _myVouchers = value;
  //=============================================================

  static final GlobVar _instance = GlobVar._internal();
  factory GlobVar() => _instance;

  //init State
  GlobVar._internal() {
    initGlobVar();
  }
  initGlobVar() async {
    _isShowNotif = true;
    _isLoading = false;
    // prefs = await SharedPreferences.getInstance();
    if(prefs!=null){
      if(prefs.getString("clientCred")==null){
        prefs.setString("clientCred", json.encode({
          "id": "S1BiT8Wwxgypz7B4DdxZsw..",
          "secret" : "uxj_dNikz8JcvasOd1l3jA.."
        }).toString());
      }
    }

  }

  clear(){
    _user=null;
    _auth=null;
  }
}