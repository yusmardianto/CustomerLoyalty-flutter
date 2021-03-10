import 'package:intl/intl.dart';

class User {
  int CUST_ID;
  String NAME;
  String CORP;
  String GENDER;
  DateTime BIRTH_DATE;
  String EMAIL;
  String PHONE;
  String COMPANY_NAME;
  String STREET_NAME;
  String POSTAL_CODE;


  User(
      this.CUST_ID,
      this.NAME,
      this.CORP,
      this.GENDER,
      this.BIRTH_DATE,
      this.EMAIL,
      this.PHONE,
      this.COMPANY_NAME,
      this.STREET_NAME,
      this.POSTAL_CODE,
  );

  User.fromJson(Map<String, dynamic> json)
      :
        CUST_ID = json['CUST_ID'],
        NAME = json['NAME'],
        CORP = json['CORP'],
        GENDER = json['GENDER'],
        BIRTH_DATE = DateTime.parse(json['BIRTH_DATE']),
        EMAIL = json["EMAIL"],
        PHONE = json["PHONE"],
        COMPANY_NAME = json["COMPANY_NAME"],
        STREET_NAME = json["STREET_NAME"],
        POSTAL_CODE = json["POSTAL_CODE"];

  Map<String, dynamic> toJson()=>{
    "CUST_ID":CUST_ID,
    "NAME":NAME,
    "CORP":CORP,
    "GENDER":GENDER,
    "BIRTH_DATE":BIRTH_DATE.toString(),
    "EMAIL":EMAIL,
    "PHONE":PHONE,
    "COMPANY_NAME":COMPANY_NAME,
    "STREET_NAME":STREET_NAME,
    "POSTAL_CODE":POSTAL_CODE
  };

  Map<String, dynamic> toJsonDisplay()=>{
    "Nama_Pelanggan":NAME??'-',
    "GENDER":GENDER,
    "Tanggal_Lahir":(BIRTH_DATE==null)?'-':DateFormat("dd-MMM-yyyy").format(BIRTH_DATE),
    "EMAIL":EMAIL??'-',
    "PHONE":PHONE??'-',
    "Perusahaan":COMPANY_NAME??'-',
    "Alamat":STREET_NAME??'-',
    "Kode_Pos":POSTAL_CODE??'-',
  };
}