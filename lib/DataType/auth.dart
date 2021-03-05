class Auth{
  String login_id;
  String user_type;
  String force_change;

  Auth(
      this.login_id,
      this.user_type,
      this.force_change
      );

  Auth.fromJson(Map<String, dynamic> json)
      : login_id = json['LOGIN_ID'],
        user_type = json['TIPE_USER'],
        force_change = json["FORCE_CHANGE_PASSWD"]
  ;

  Map<String, dynamic> toJson()=>{
    'login_id': login_id,
    'user_type': user_type,
    "force_change" : force_change
  };
}