class Voucher{
  String NAME;
  String BRAND_NAME;
  String CAMPAIGN_TYPE;
  String INFORMATION_LINK;
  String PUSH_NOTIF_TEXT;
  String PERIOD;
  int COST_IN_POINT;
  String REWARD_VALUE;
  int LOYALTY_CAMPAIGN_ID;
  String SHORT_DESC;
  String CONDITION_DESC;
  String HOW_TO_USE;
  String BRAND_DESC;

  Voucher(
      this.NAME,
      this.BRAND_NAME,
      this.CAMPAIGN_TYPE,
      this.INFORMATION_LINK,
      this.PUSH_NOTIF_TEXT,
      this.PERIOD,
      this.COST_IN_POINT,
      this.REWARD_VALUE,
      this.LOYALTY_CAMPAIGN_ID,
      this.SHORT_DESC,
      this.CONDITION_DESC,
      this.HOW_TO_USE,
      this.BRAND_DESC
      );

  Voucher.fromJson(Map<String, dynamic> json)
      : NAME = json['NAME'],
        BRAND_NAME = json['BRAND_NAME'],
        CAMPAIGN_TYPE = json["CAMPAIGN_TYPE"],
        INFORMATION_LINK = json["INFORMATION_LINK"],
        PUSH_NOTIF_TEXT = json["PUSH_NOTIF_TEXT"],
        PERIOD = json["PERIOD"],
        COST_IN_POINT = json["COST_IN_POINT"],
        REWARD_VALUE = json["REWARD_VALUE_P"],
        LOYALTY_CAMPAIGN_ID = json["LOYALTY_CAMPAIGN_ID"],
        SHORT_DESC = json["SHORT_DESC"],
        CONDITION_DESC = json["CONDITION_DESC"],
        HOW_TO_USE = json["HOW_TO_USE"],
        BRAND_DESC = json["BRAND_DESC"]
  ;

  Map<String, dynamic> toJson()=>{
    "NAME" : NAME,
    "BRAND_NAME" : BRAND_NAME,
    "CAMPAIGN_TYPE" : CAMPAIGN_TYPE,
    "INFORMATION_LINK" : INFORMATION_LINK,
    "PUSH_NOTIF_TEXT" : PUSH_NOTIF_TEXT,
    "PERIOD" : PERIOD,
    "COST_IN_POINT" : COST_IN_POINT,
    "REWARD_VALUE" : REWARD_VALUE,
    "LOYALTY_CAMPAIGN_ID" : LOYALTY_CAMPAIGN_ID,
    "SHORT_DESC" : SHORT_DESC,
    "CONDITION_DESC" : CONDITION_DESC,
    "HOW_TO_USE" : HOW_TO_USE,
    "BRAND_DESC" : BRAND_DESC
  };
  Map<String, dynamic> toJsonDisplay()=>{
    "Nama" : NAME,
    "Brand" : BRAND_NAME,
    "Berlaku" : PERIOD,
    "Tipe Voucher" : CAMPAIGN_TYPE,
    "Info Detail" : INFORMATION_LINK,
    "Harga Point" : COST_IN_POINT,
    "Point Hadiah" : REWARD_VALUE,
    "Deskripsi" : SHORT_DESC,
    "Syarat" : CONDITION_DESC,
    "Penggunaan" : HOW_TO_USE,
    "Tentang Brand" : BRAND_DESC
  };
}

class MyVoucher{
  String DESCRIPTION;
  String STATUS;
  String COUPON;
  String PERIOD;
  DateTime CREATED_DATE;
  String REWARD_VALUE;
  int LOYALTY_CUST_REWARD_ID;
  int LOYALTY_CAMPAIGN_ID;



  MyVoucher(
      this.DESCRIPTION,
      this.STATUS,
      this.COUPON,
      this.PERIOD,
      this.CREATED_DATE,
      this.REWARD_VALUE,
      this.LOYALTY_CUST_REWARD_ID,
      this.LOYALTY_CAMPAIGN_ID,
      );

  MyVoucher.fromJson(Map<String, dynamic> json)
      : DESCRIPTION = json['DESCRIPTION'],
        STATUS = json['STATUS'],
        COUPON = json["COUPON"],
        PERIOD = json["PERIOD"],
        CREATED_DATE = DateTime.parse(json["CREATED_DATE"]).toLocal(),
        REWARD_VALUE = json["REWARD_VALUE_P"],
        LOYALTY_CUST_REWARD_ID = json["LOYALTY_CUST_REWARD_ID"],
        LOYALTY_CAMPAIGN_ID = json["LOYALTY_CAMPAIGN_ID"]
  ;

  Map<String, dynamic> toJson()=>{
    "DESCRIPTION" : DESCRIPTION,
    "STATUS" : STATUS,
    "COUPON" : COUPON,
    "PERIOD" : PERIOD,
    "CREATED_DATE" : CREATED_DATE,
    "REWARD_VALUE" : REWARD_VALUE,
    "LOYALTY_CUST_REWARD_ID": LOYALTY_CUST_REWARD_ID,
    "LOYALTY_CAMPAIGN_ID" : LOYALTY_CAMPAIGN_ID
  };
}