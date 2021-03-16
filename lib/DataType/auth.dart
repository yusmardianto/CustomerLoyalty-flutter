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
    'LOGIN_ID': login_id,
    'TIPE_USER': user_type,
    "FORCE_CHANGE_PASSWD" : force_change,
    "G_CORP" :corp,
    "OWNER" : owner
  };
}