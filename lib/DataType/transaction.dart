class Transaction{
  String LOYALTY_TRANSACTION_ID;
  String DESCRIPTION;
  String DOCUMENT_TYPE;
  String POS_NAME;
  String CUST_NAME;
  DateTime TRANSACTION_DATE;
  int POINT_EARN;
  int GRAND_TOTAL;

  Transaction(
      this.LOYALTY_TRANSACTION_ID,
      this.DESCRIPTION,
      this.DOCUMENT_TYPE,
      this.POS_NAME,
      this.CUST_NAME,
      this.TRANSACTION_DATE,
      this.POINT_EARN,
      this.GRAND_TOTAL
      );

  Transaction.fromJson(Map<String, dynamic> json)
      : LOYALTY_TRANSACTION_ID = json['LOYALTY_TRANSACTION_ID'],
        DESCRIPTION = json['DESCRIPTION'],
        DOCUMENT_TYPE = json["DOCUMENT_TYPE"],
        POS_NAME = json["POS_NAME"],
        CUST_NAME = json["CUST_NAME"],
        TRANSACTION_DATE = DateTime.parse(json["TRANSACTION_DATE"]).toLocal(),
        POINT_EARN = json["POINT_EARN"],
        GRAND_TOTAL = json["GRAND_TOTAL"]
  ;

  Map<String, dynamic> toJson()=>{
    "LOYALTY_TRANSACTION_ID" : LOYALTY_TRANSACTION_ID,
    "DESCRIPTION" : DESCRIPTION,
    "DOCUMENT_TYPE" : DOCUMENT_TYPE,
    "POS_NAME" : POS_NAME,
    "CUST_NAME" : CUST_NAME,
    "TRANSACTION_DATE" : TRANSACTION_DATE,
    "POINT_EARN" : POINT_EARN,
    "GRAND_TOTAL" : GRAND_TOTAL
  };
}