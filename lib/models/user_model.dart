// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? name;
  String? email;
  List<String>? skills;
  String? expereince;
  String? avatarPath;

  UserModel({
    this.name,
    this.email,
    this.skills,
    this.expereince,
    this.avatarPath,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"]!.map((x) => x)),
        expereince: json["expereince"],
        avatarPath: json["avatar_path"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "expereince": expereince,
        "avatar_path": avatarPath,
      };
}
