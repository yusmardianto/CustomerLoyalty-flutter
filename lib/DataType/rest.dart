class Rest{
  String token;
  DateTime expire;

  Rest(
      this.token,
      this.expire);

  Rest.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        expire = DateTime.parse(json['expire'])
  ;

  Map<String, dynamic> toJson()=>{
    'token': token,
    'expire': expire.toString()
  };
}