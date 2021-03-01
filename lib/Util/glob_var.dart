import "package:shared_preferences/shared_preferences.dart";
class GlobaVar{
  //=====================shownotif============================
  bool _isShowNotif;
  bool get isShowNotif => _isShowNotif;
  set isShowNotif(bool value) => _isShowNotif = value;
  //======================shared_pref=========================
  SharedPreferences _prefs;
  SharedPreferences get prefs => _prefs;
  //======================client-rest-oracle==================
  Map _clientRest;
  Map get clientRest => _clientRest;


  static final GlobaVar _instance = GlobaVar._internal();
  factory GlobaVar() => _instance;

  //init State
  GlobaVar._internal() {
    initGlobVar();
  }
  void initGlobVar() async {
    _isShowNotif = true;
    _clientRest = {
      "id": "S1BiT8Wwxgypz7B4DdxZsw..",
      "secret" : "uxj_dNikz8JcvasOd1l3jA.."
    };
    _prefs = await SharedPreferences.getInstance();
  }
}