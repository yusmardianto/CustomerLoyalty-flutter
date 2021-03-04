import 'package:intl/intl.dart';

import '../main.dart';
class User {
  String login_id;
  int cust_id;
  String name;
  String corp;
  String gender;
  DateTime birth_date;
  String email;
  String phone;
  String company_name;
  String street_name;
  String postal_code;
  String user_type;
  String force_change;

  User(
      this.login_id,
      this.cust_id,
      this.name,
      this.corp,
      this.gender,
      this.birth_date,
      this.email,
      this.phone,
      this.company_name,
      this.street_name,
      this.postal_code,
      this.user_type,
      this.force_change,);

  User.fromJson(Map<String, dynamic> json)
      : login_id = json['login_id'],
        cust_id = json['cust_id'],
        name = json['name'],
        corp = json['corp'],
        gender = json['gender'],
        birth_date = DateTime.parse(json['birth_date']),
        email = json["email"],
        phone = json["phone"],
        company_name = json["company_name"],
        street_name = json["street_name"],
        postal_code = json["postal_code"],
        user_type = json["user_type"],
        force_change = json['force_change']
  ;

  Map<String, dynamic> toJson()=>{
    "login_id":login_id,
    "cust_id":cust_id,
    "name":name,
    "corp":corp,
    "gender":gender,
    "birth_date":birth_date.toString(),
    "email":email,
    "phone":phone,
    "company_name":company_name,
    "street_name":street_name,
    "postal_code":postal_code,
    "user_type":user_type,
    "force_change":force_change
  };

  Map<String, dynamic> toJsonDisplay()=>{
    "Nama Pelanggan":name??'-',
    "Gender":gender,
    "Tanggal Lahir":(birth_date==null)?'-':DateFormat("dd-MM-yyyy").format(birth_date),
    "Email":email??'-',
    "Telephone":phone??'-',
    "Perusahaan":company_name??'-',
    "Alamat":street_name??'-',
    "Kode Pos":postal_code??'-',
  };
}