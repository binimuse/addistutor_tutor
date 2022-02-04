import 'dart:convert';

import 'dart:io';

import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

import 'api.dart';

class RemoteServices {
  // ignore: prefer_typing_uninitialized_variables
  static var res, body;
  static List<String> sent = [];

  static Future<String> editPersonalInfo(var data) async {
    List<String> errors = [];
    // create multipart request
    res = await Network().getpassedData(data, "update-profile-teacher");

    body = json.decode(res.body);
    print("body");
    print(body);
    if (res.statusCode == 200) {
      return res.statusCode.toString();
    } else {
      if (body["message"] != null) {
        return body["message"].toString();
      } else {
        Map<String, dynamic> map = body["errors"];
        map.forEach((key, value) {
          errors.add(value[0].toString());
        });

        return errors.join("\n").toString();
      }
    }
  }

  static Future<String> editAvalablitydate(var data) async {
    List<String> errors = [];
    // create multipart request
    res = await Network().getpassedData(data, "teacher-availability");

    body = json.decode(res.body);
    print("body");
    print(body);
    if (res.statusCode == 200) {
      return res.statusCode.toString();
    } else {
      if (body["message"] != null) {
        return body["message"].toString();
      } else {
        Map<String, dynamic> map = body["errors"];
        map.forEach((key, value) {
          errors.add(value[0].toString());
        });

        return errors.join("\n").toString();
      }
    }
  }

  static Future<String> editAvalablity(var data, id) async {
    List<String> errors = [];
    print("id");
    print(id);
    // create multipart request
    res = await Network()
        .getpassedData(data, "teacher/${id.toString()}/update-status");

    body = json.decode(res.body);
    print("body");
    print(body);
    if (res.statusCode == 200) {
      return res.statusCode.toString();
    } else {
      if (body["message"] != null) {
        return body["message"].toString();
      } else {
        Map<String, dynamic> map = body["errors"];
        map.forEach((key, value) {
          errors.add(value[0].toString());
        });

        return errors.join("\n").toString();
      }
    }
  }

  static Future<Teacher> fetchpf(var id) async {
    // print("id.toString()");
    //print(id.toString());
    res = await Network().getData("teacher/${id.toString()}");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      //  print(body);
      return Teacher.fromJson(body);
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<bool> uploadImage(File image, String id) async {
    // ignore: unnecessary_null_comparison

    print("object");
    print(image.toString());
    print(id);
    if (image != null) {
      // ignore: deprecated_member_use
      var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();
      // create multipart request
      res = await Network()
          .uploadFile("teacher/${id}/updateProfile", image, stream, length);

      if (res.statusCode == 200) {
        res.stream.transform(utf8.decoder).listen((value) {});
        return true;
      } else {
        throw Exception('Failed to Upload file' + res.statusCode.toString());
      }
    } else {
      return false;
    }
  }

  static Future<List<Activedays>> fetchdaya() async {
    res = await Network().getData("teacher-availability");

    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => Activedays.fromJson(e))
          .toList()
          .cast<Activedays>();
    } else {
      throw Exception('Failed to load days' + res.statusCode.toString());
    }
  }

  static Future<String> feedback(var data) async {
    List<String> errors = [];
    // create multipart request
    res = await Network().getpassedData(data, "feedback");

    body = json.decode(res.body);

    if (res.statusCode == 200) {
      return res.statusCode.toString();
    } else {
      if (body["message"] != null) {
        return body["message"].toString();
      } else {
        Map<String, dynamic> map = body["errors"];
        map.forEach((key, value) {
          errors.add(value[0].toString());
        });

        return errors.join("\n").toString();
      }
    }
  }

  static Future<String> wallet(File image, var data, var id) async {
    // create multipart request
    var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    res = await Network()
        .postFile2("wallet/${id}/deposit", image, data, stream, length);
    print(res.statusCode.toString());
    if (res.statusCode == 200) {
      res.stream.transform(utf8.decoder).listen((value) {});

      return res.statusCode.toString();
    } else {
      throw Exception("can't");
    }
  }

  static Future<Balance> balance(var id) async {
    res = await Network().getData("wallet/${id}/balance");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return Balance.fromJson(body["data"]);
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }
}
