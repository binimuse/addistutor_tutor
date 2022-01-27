// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

class Teacher {
  int id;

  String first_name;

  String last_name;
  String middle_name;
  String phone_no;
  String email;

  String birth_date;

  String about;
  String is_active;

  Teacher({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.middle_name,
    required this.phone_no,
    required this.email,
    required this.birth_date,
    required this.about,
    required this.is_active,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json["id"] as int,
      first_name: json["first_name"],
      last_name: json["last_name"],
      middle_name: json["middle_name"],
      phone_no: json["phone_no"],
      email: json["email"],
      birth_date: json["birth_date"],
      about: json["about"],
      is_active: json["is_active"],
    );
  }
}

class Activedays {
  String day;

  Activedays({
    required this.day,
  });

  factory Activedays.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> jsons = json["data"];
    return Activedays(
      day: jsons["day"],
    );
  }
}
