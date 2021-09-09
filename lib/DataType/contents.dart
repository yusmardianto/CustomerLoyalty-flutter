import 'dart:convert';
import 'dart:typed_data';

class Content{
  String title;
  String short_title;
  int msg_id;
  String message_body;
  String message_image;
  DateTime date;
  String message_thumbnail;


  Content(this.title,this.short_title,this.msg_id,this.message_body,this.message_image,this.date);

  Content.fromJson(Map<String, dynamic> json){
    var jsonKeys = json.keys.toList();
    this.title = json[jsonKeys[0]];
    this.short_title = json[jsonKeys[1]];
    this.msg_id = json[jsonKeys[2]];
    this.message_body = json[jsonKeys[3]];
    // this.message_image = (json[jsonKeys[4]]!=null||json[jsonKeys[4]]!='null')?Base64Decoder().convert(json[jsonKeys[4]]):null;
    this.message_image = json[jsonKeys[4]];
    this.date = (json[jsonKeys[5]]!=null||json[jsonKeys[5]]!='null')?DateTime.parse(json[jsonKeys[5]]).toLocal():null;
    this.message_thumbnail = json[jsonKeys[6]];
  }


  Map<String, dynamic> toJson()=>{
    'title': title,
    'short_title': short_title,
    "msg_id" : msg_id,
    "message_body" :message_body,
    "message_image" : message_image,
    "date" : date,
    "message_thumbnail" : message_thumbnail,
  };

}