class User {
  String loginId;
  String username;
  String corp;
  String custId;
  String userType;
  String forceChange;
  String typeUser;

  User(
      this.loginId,
      this.username,
      this.corp,
      this.custId,
      this.forceChange,
      this.typeUser);

  User.fromJson(Map<String, dynamic> json)
      : loginId = json['loginId'],
        username = json['username'],
        corp = json['corp'],
        custId = json['custId'],
        forceChange = json['forceChange'],
        typeUser = json["typeUser"]
  ;

  Map<String, dynamic> toJson()=>{
      'loginId': loginId,
      'username': username,
      'corp' : corp,
      'custId':custId,
      "userType":userType,
      "forceChange":forceChange,
      "typeUser":typeUser
  };
}