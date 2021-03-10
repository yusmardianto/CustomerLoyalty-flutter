class Voucher{
  String NAME;
  String BRAND_NAME;
  String CAMPAIGN_TYPE;
  String INFORMATION_LINK;
  String PUSH_NOTIF_TEXT;
  String PERIOD;
  int COST_IN_POINT;
  int REWARD_VALUE;
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
        REWARD_VALUE = json["REWARD_VALUE"],
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
    "SHORT_DESC" : SHORT_DESC,
    "CONDITION_DESC" : CONDITION_DESC,
    "HOW_TO_USE" : HOW_TO_USE,
    "BRAND_DESC" : BRAND_DESC
  };
}