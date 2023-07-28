/// ClientModel.dart
import 'dart:convert';

Demo clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Demo.fromMap(jsonData);
}

String clientToJson(Demo data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Demo {
  int id;
  String? author;
  String text;
  bool status;

  Demo({
    required this.id,
    this.author,
    required this.text,
    required this.status,
  });

  factory Demo.fromMap(Map<String, dynamic> json) => Demo(
        id: json["id"],
        text: json["todo"],
        status:false,
      );

    factory Demo.fromMaSQl(Map<String, dynamic> json) => Demo(
        id: json["id"],
        text: json["text"],
        author: json["author"],
        status: json["status"]==1,
      );

  Map<String, dynamic> toMap() => {
        "author": author,
        "text": text,
        "status": status,
      };
}