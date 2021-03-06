class Auth{
  String login_id;
  String user_type;
  String force_change;
  String corp;
  String owner;
  Auth(
      this.login_id,
      this.user_type,
      this.force_change,
      this.corp,
      this.owner
      );

  Auth.fromJson(Map<String, dynamic> json)
      : login_id = json['LOGIN_ID'],
        user_type = json['TIPE_USER'],
        force_change = json["FORCE_CHANGE_PASSWD"],
        corp = json["G_CORP"],
        owner = json["OWNER"]
  ;

  Map<String, dynamic> toJson()=>{
    'login_id': login_id,
    'user_type': user_type,
    "force_change" : force_change,
    "corp" :corp,
    "owner" : owner
  };
}