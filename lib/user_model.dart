// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.name,
        this.regNo,
        this.results,
        this.lecturerEmail,
        this.studentEmail,
    });

    String name;
    String regNo;
    String results;
    String lecturerEmail;
    String studentEmail;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        regNo: json["regNo"],
        results: json["results"],
        lecturerEmail: json["lecturerEmail"],
        studentEmail: json["studentEmail"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "regNo": regNo,
        "results": results,
        "lecturerEmail": lecturerEmail,
        "studentEmail": studentEmail,
    };
}
