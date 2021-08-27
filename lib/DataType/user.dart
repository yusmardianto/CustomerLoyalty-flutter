import 'dart:convert';
import 'dart:typed_data';

import 'package:intl/intl.dart';

class User {
  int CUST_ID;
  int CUST_POINT;
  int MEMBERSHIP_ID;
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
  String IDENTITY_NUMBER;
  String CITY;
  String PROVINCE;
  Uint8List LOYALTY_LEVEL_IMAGE;
  Uint8List CUST_PROFILE_IMAGE;
  String MEMBERSHIP;
  Uint8List MEMBERSHIP_IMAGE;

  User(
      this.CUST_ID,
      this.CUST_POINT,
      this.MEMBERSHIP_ID,
      this.NAME,
      this.CORP,
      this.GENDER,
      this.BIRTH_DATE,
      this.EMAIL,
      this.PHONE,
      this.COMPANY_NAME,
      this.STREET_NAME,
      this.POSTAL_CODE,
      this.LOYALTY_LEVEL,
      this.IDENTITY_NUMBER,
      this.CITY,
      this.PROVINCE,
      this.LOYALTY_LEVEL_IMAGE,
      this.CUST_PROFILE_IMAGE,
      this.MEMBERSHIP,
      this.MEMBERSHIP_IMAGE,
  );

  User.fromJson(Map<String, dynamic> json){
    var jsonKeys = json.keys.toList();
    this.CORP = json[jsonKeys[0]].toString();
    this.CUST_ID = json[jsonKeys[1]];
    this.CUST_POINT = json[jsonKeys[2]];
    this.MEMBERSHIP_ID = json[jsonKeys[3]];
    this.NAME = json[jsonKeys[4]];
    this.GENDER = json[jsonKeys[5]];
    this.IDENTITY_NUMBER = json[jsonKeys[6]];
    this.BIRTH_DATE =  (json[jsonKeys[7]]==null||json[jsonKeys[7]]=='null')?null:DateTime.parse(json[jsonKeys[7]]).toLocal();
    this.EMAIL = json[jsonKeys[8]];
    this.PHONE = json[jsonKeys[9]];
    this.COMPANY_NAME = json[jsonKeys[10]];
    this.STREET_NAME = json[jsonKeys[11]];
    this.POSTAL_CODE = json[jsonKeys[12]];
    this.LOYALTY_LEVEL = json[jsonKeys[13]];
    this.CITY = json[jsonKeys[14]];
    this.PROVINCE = json[jsonKeys[15]];
    this.LOYALTY_LEVEL_IMAGE = (json[jsonKeys[16]]==null||json[jsonKeys[16]]=='null')?null:Base64Decoder().convert(json[jsonKeys[16]]);
    this.CUST_PROFILE_IMAGE = (json[jsonKeys[17]]==null||json[jsonKeys[17]]=='null')?null:Base64Decoder().convert(json[jsonKeys[17]]);
    this.MEMBERSHIP = json[jsonKeys[18]];
    this.MEMBERSHIP_IMAGE =  (json[jsonKeys[19]]==null||json[jsonKeys[19]]=='null')?null:Base64Decoder().convert(json[jsonKeys[19]]);
  }

  // User.fromJson(Map<String, dynamic> json)
  //     :
  //       CUST_ID = json['CUST_ID'],
  //       CUST_POINT = json["CUST_POINT"],
  //       NAME = json['NAME'],
  //       CORP = json['CORP'],
  //       GENDER = json['GENDER'],
  //       BIRTH_DATE = DateTime.parse(json['BIRTH_DATE']),
  //       EMAIL = json["EMAIL"],
  //       PHONE = json["PHONE"],
  //       COMPANY_NAME = json["COMPANY_NAME"],
  //       STREET_NAME = json["STREET_NAME"],
  //       POSTAL_CODE = json["POSTAL_CODE"],
  //       LOYALTY_LEVEL = json["LOYALTY_LEVEL"],
  //       IDENTITY_NUMBER = json["IDENTITY_NUMBER"],
  //       CITY = json["CITY"],
  //       PROVINCE = json["PROVINCE"],
  //       LOYALTY_LEVEL_PHOTO = json["LOYALTY_LEVEL_PHOTO"],
  //       CUST_DISPLAY_PICTURE = json["CUST_DISPLAY_PICTURE"];

  Map<String, dynamic> toJson()=>{
    "CORP":CORP,
    "CUST_ID":CUST_ID,
    "CUST_POINT":CUST_POINT,
    "MEMBERSHIP_ID":MEMBERSHIP_ID,
    "NAME":NAME,
    "GENDER":GENDER,
    "IDENTITY_NUMBER" : IDENTITY_NUMBER,
    "BIRTH_DATE":BIRTH_DATE.toString(),
    "EMAIL":EMAIL,
    "PHONE":PHONE,
    "COMPANY_NAME":COMPANY_NAME,
    "STREET_NAME":STREET_NAME,
    "POSTAL_CODE":POSTAL_CODE,
    "LOYALTY_LEVEL":LOYALTY_LEVEL,
    "CITY" : CITY,
    "PROVINCE" : PROVINCE,
    "LOYALTY_LEVEL_IMAGE":LOYALTY_LEVEL_IMAGE==null?null:Base64Encoder().convert(LOYALTY_LEVEL_IMAGE),
    "CUST_PROFILE_IMAGE" :CUST_PROFILE_IMAGE==null?null: Base64Encoder().convert(CUST_PROFILE_IMAGE),
    "MEMBERSHIP" :MEMBERSHIP,
    "MEMBERSHIP_IMAGE" :MEMBERSHIP_IMAGE==null?null: Base64Encoder().convert(MEMBERSHIP_IMAGE),
  };

  Map<String, dynamic> toJsonDisplay()=>{
    "Nama":NAME??'',
    "Gender":GENDER??'',
    "Tanggal_Lahir":(BIRTH_DATE==null)?null:DateFormat("dd-MMM-yyyy").format(BIRTH_DATE),
    "Email":EMAIL??'',
    "Phone":PHONE??'',
    "Alamat":STREET_NAME??'',
    "Kode_Pos":POSTAL_CODE??'',
    "No_Ktp" : IDENTITY_NUMBER??'',
    "Kota" : CITY??'',
    "Provinsi" : PROVINCE??''
  };
}