class GlobaVar{
  //=====================shownotif============================
  bool _isShowNotif;
  bool get isShowNotif => _isShowNotif;
  set isShowNotif(bool value) => _isShowNotif = value;
  //==========================================================

  static final GlobaVar _instance = GlobaVar._internal();
  factory GlobaVar() => _instance;
  //init State
  GlobaVar._internal() {
    _isShowNotif = true;
  }
}