import 'package:intl/intl.dart';

class User {
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


  User(
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
  );

  User.fromJson(Map<String, dynamic> json)
      :
        cust_id = json['cust_id'],
        name = json['name'],
        corp = json['corp'],
        gender = json['gender'],
        birth_date = DateTime.parse(json['birth_date']),
        email = json["email"],
        phone = json["phone"],
        company_name = json["company_name"],
        street_name = json["street_name"],
        postal_code = json["postal_code"];

  Map<String, dynamic> toJson()=>{
    "cust_id":cust_id,
    "name":name,
    "corp":corp,
    "gender":gender,
    "birth_date":birth_date.toString(),
    "email":email,
    "phone":phone,
    "company_name":company_name,
    "street_name":street_name,
    "postal_code":postal_code
  };

  Map<String, dynamic> toJsonDisplay()=>{
    "Nama_Pelanggan":name??'-',
    "Gender":gender,
    "Tanggal_Lahir":(birth_date==null)?'-':DateFormat("dd-MMM-yyyy").format(birth_date),
    "Email":email??'-',
    "Phone":phone??'-',
    "Perusahaan":company_name??'-',
    "Alamat":street_name??'-',
    "Kode_Pos":postal_code??'-',
  };
}