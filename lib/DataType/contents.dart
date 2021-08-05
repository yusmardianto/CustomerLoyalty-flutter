import 'dart:convert';
import 'dart:typed_data';

class NewsBanner{
  String title;
  String short_title;
  int msg_id;
  String message_body;
  Uint8List message_image;
  DateTime date;

  NewsBanner(this.title,this.short_title,this.msg_id,this.message_body,this.message_image,this.date);

  NewsBanner.fromJson(Map<String, dynamic> json){
    var jsonKeys = json.keys.toList();
    this.title = json[jsonKeys[0]];
    this.short_title = json[jsonKeys[1]];
    this.msg_id = json[jsonKeys[2]];
    this.message_body = json[jsonKeys[3]];
    this.message_image = (json[jsonKeys[4]]!=null||json[jsonKeys[4]]!='null')?Base64Decoder().convert(json[jsonKeys[4]]):null;
    this.date = (json[jsonKeys[5]]!=null||json[jsonKeys[5]]!='null')?DateTime.parse(json[jsonKeys[5]]).toLocal():null;
  }


  Map<String, dynamic> toJson()=>{
    'title': title,
    'short_title': short_title,
    "msg_id" : msg_id,
    "message_body" :message_body,
    "message_image" : message_image,
    "date" : date
  };

}