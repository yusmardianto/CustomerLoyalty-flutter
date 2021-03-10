class Transaction{
  String LOYALTY_TRANSACTION_ID;
  String DOCUMENT_NUMBER;
  String DOCUMENT_TYPE;
  String POS_NAME;
  String CUST_NAME;
  DateTime TRANSACTION_DATE;
  int POINT_EARN;

  Transaction(
      this.LOYALTY_TRANSACTION_ID,
      this.DOCUMENT_NUMBER,
      this.DOCUMENT_TYPE,
      this.POS_NAME,
      this.CUST_NAME,
      this.TRANSACTION_DATE,
      this.POINT_EARN
      );

  Transaction.fromJson(Map<String, dynamic> json)
      : LOYALTY_TRANSACTION_ID = json['LOYALTY_TRANSACTION_ID'],
        DOCUMENT_NUMBER = json['DOCUMENT_NUMBER'],
        DOCUMENT_TYPE = json["DOCUMENT_TYPE"],
        POS_NAME = json["POS_NAME"],
        CUST_NAME = json["CUST_NAME"],
        TRANSACTION_DATE = DateTime.parse(json["TRANSACTION_DATE"]),
        POINT_EARN = json["POINT_EARN"]
  ;

  Map<String, dynamic> toJson()=>{
    "LOYALTY_TRANSACTION_ID" : LOYALTY_TRANSACTION_ID,
    "DOCUMENT_NUMBER" : DOCUMENT_NUMBER,
    "DOCUMENT_TYPE" : DOCUMENT_TYPE,
    "POS_NAME" : POS_NAME,
    "CUST_NAME" : CUST_NAME,
    "TRANSACTION_DATE" : TRANSACTION_DATE,
    "POINT_EARN" : POINT_EARN
  };
}