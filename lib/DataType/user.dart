import 'package:intl/intl.dart';

class User {
  int CUST_ID;
  int CUST_POINT;
  String NAME;
  String CORP;
  String GENDER;
  DateTime BIRTH_DATE;
  String EMAIL;
  String PHONE;
  String COMPANY_NAME;
  String STREET_NAME;
  String POSTAL_CODE;
  String LOYALTY_LEVEL;


  User(
      this.CUST_ID,
      this.CUST_POINT,
      this.NAME,
      this.CORP,
      this.GENDER,
      this.BIRTH_DATE,
      this.EMAIL,
      this.PHONE,
      this.COMPANY_NAME,
      this.STREET_NAME,
      this.POSTAL_CODE,
      this.LOYALTY_LEVEL
  );

  User.fromJson(Map<String, dynamic> json)
      :
        CUST_ID = json['CUST_ID'],
        CUST_POINT = json["CUST_POINT"],
        NAME = json['NAME'],
        CORP = json['CORP'],
        GENDER = json['GENDER'],
        BIRTH_DATE = DateTime.parse(json['BIRTH_DATE']),
        EMAIL = json["EMAIL"],
        PHONE = json["PHONE"],
        COMPANY_NAME = json["COMPANY_NAME"],
        STREET_NAME = json["STREET_NAME"],
        POSTAL_CODE = json["POSTAL_CODE"],
        LOYALTY_LEVEL = json["LOYALTY_LEVEL"];

  Map<String, dynamic> toJson()=>{
    "CUST_ID":CUST_ID,
    "CUST_POINT":CUST_POINT,
    "NAME":NAME,
    "CORP":CORP,
    "GENDER":GENDER,
    "BIRTH_DATE":BIRTH_DATE.toString(),
    "EMAIL":EMAIL,
    "PHONE":PHONE,
    "COMPANY_NAME":COMPANY_NAME,
    "STREET_NAME":STREET_NAME,
    "POSTAL_CODE":POSTAL_CODE,
    "LOYALTY_LEVEL":LOYALTY_LEVEL
  };

  Map<String, dynamic> toJsonDisplay()=>{
    "Nama_Pelanggan":NAME??'-',
    "Gender":GENDER,
    "Tanggal_Lahir":(BIRTH_DATE==null)?'-':DateFormat("dd-MMM-yyyy").format(BIRTH_DATE),
    "EMAIL":EMAIL??'-',
    "PHONE":PHONE??'-',
    "Perusahaan":COMPANY_NAME??'-',
    "Alamat":STREET_NAME??'-',
    "Kode_Pos":POSTAL_CODE??'-',
  };
}