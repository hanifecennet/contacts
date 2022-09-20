import 'dart:convert';

List<RehberModel> rehberModelFromJson(String str) => List<RehberModel>.from(json.decode(str).map((x) => RehberModel.fromJson(x)));

String rehberModelToJson(List<RehberModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RehberModel {
    RehberModel({
        this.id,
        this.name,
        this.username,
        this.email,
        this.phone,
        this.image,
    });

    String? id;
    String? name;
    String? username;
    String? email;
    String? phone;
    dynamic image;

    factory RehberModel.fromJson(Map<String, dynamic> json) => RehberModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "phone": phone,
        "image": image,
    };
}


/*import 'package:flutter/src/widgets/framework.dart';

class RehberModel 
{
  String? id;
  String? name;
  String? username;
  String? email;
  String? phone;

  RehberModel({this.id, this.name, this.username, this.email, this.phone});

  RehberModel.fromJson(Map<String, dynamic> json) 
  {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() 
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }

 // of(BuildContext context) {}
}*/