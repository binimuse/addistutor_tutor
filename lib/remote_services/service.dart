// ignore_for_file: unnecessary_null_comparison, duplicate_ignore, unnecessary_brace_in_string_interps, deprecated_member_use

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
    res = await Network().getpassedData(data, "teacher");

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

  static Future<String> UpdateProfile(var data) async {
    List<String> errors = [];
    // create multipart request
    res = await Network().getpassedData(data, "teacher-update");

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

  static Future<String> editAvalablitydate(var data) async {
    List<String> errors = [];
    // create multipart request
    res = await Network().getpassedData(data, "teacher-availability");

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

  static Future<String> editAvalablity(var data, id) async {
    List<String> errors = [];

    // create multipart request
    res = await Network()
        .getpassedData(data, "teacher/${id.toString()}/update-status");

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

  static Future<List<Transaction>> transaction(var id) async {
    res = await Network().getData("wallet/${id}/transaction");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => Transaction.fromJson(e))
          .toList()
          .cast<Transaction>();
    } else {
      throw Exception('Failed to load transaction');
    }
  }

  static Future<ContactUS> contactus() async {
    res = await Network().getData("contact-us");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return ContactUS.fromJson(body["data"]);
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<String> updatepass(
    var data,
  ) async {
    List<String> errors = [];
    // ignore: unnecessary_brace_in_string_interps
    res = await Network().getpassedData(data, "change-password");
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

  static Future<List<Notifications>> getActivity() async {
    res = await Network().getData("teacher-notification");
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => Notifications.fromJson(e))
          .toList()
          .cast<Notifications>();
    } else {
      throw Exception('Failed to load Comment');
    }
  }

  static Future<List<RequestedBooking>> getrequestedbooking(
      var id, var status) async {
    res = await Network().getData("teacher/${id}/bookings?status=${status}");
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => RequestedBooking.fromJson(e))
          .toList()
          .cast<RequestedBooking>();
    } else {
      throw Exception('Failed to load Comment');
    }
  }

  static Future<String> updatestatus(var data, var bId) async {
    List<String> errors = [];
    // create multipart request
    res = await Network().getpassedData(data, "booking/${bId}/update-status");

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

  static Future<String> qrcode(
    var data,
  ) async {
    List<String> errors = [];
    // create multipart request
    res = await Network().getpassedData(data, "take-attendance");

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

  static Future<String> forgott(
    var data,
  ) async {
    List<String> errors = [];
    // ignore: unnecessary_brace_in_string_interps
    res = await Network().getpassedData(data, "password/email");
    body = json.decode(res.body);
    // ignore: avoid_print
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

  static Future<List<Teacher2>> getpopular() async {
    res = await Network().getData("top-tutors");
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => Teacher2.fromJson(e))
          .toList()
          .cast<Teacher2>();
    } else {
      throw Exception('Failed to load Comment');
    }
  }

  static Future<RequestedBooking> getsinglebooking(var bId) async {
    res = await Network().getData("booking/${bId}");

    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return RequestedBooking.fromJson(body["data"]);
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<List<GetLocation>> getlocation() async {
    // print("id.toString()");
    //print(id.toString());
    res = await Network().getData("address?with_address=true");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body
          .map((e) => GetLocation.fromJson(e))
          .toList()
          .cast<GetLocation>();
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<List<GetLevel>> getlevel() async {
    // print("id.toString()");
    //print(id.toString());
    res = await Network().getData("tutoring-level");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => GetLevel.fromJson(e))
          .toList()
          .cast<GetLevel>();
    } else {
      throw Exception('Failed to load Comment');
    }
  }

  static Future<List<Subjects2>> getsubject2() async {
    res = await Network().getData("subjects");

    var body = json.decode(res.body);

    // print("body");
    print(body["data"]);
    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => Subjects2.fromJson(e))
          .toList()
          .cast<Subjects2>();
    } else {
      throw Exception('Failed to load Comment');
    }
  }

  static Future<List<Subjects>> getsubject(var tid) async {
    print(tid);
    res = await Network().getData("subjects?tutoring_level_id=${tid}");

    var body = json.decode(res.body);

    // print("body");
    print(body["data"]);
    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => Subjects.fromJson(e))
          .toList()
          .cast<Subjects>();
    } else {
      throw Exception('Failed to load Comment');
    }
  }

  static Future<List<GetQulification>> getqualification() async {
    // print("id.toString()");
    //print(id.toString());
    res = await Network().getData("qualifications");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => GetQulification.fromJson(e))
          .toList()
          .cast<GetQulification>();
    } else {
      throw Exception('Failed to load Comment');
    }
  }

  static Future<String> endbooking(var ending_reason, var id) async {
    var data = {
      'ending_reason': ending_reason,
    };
    res = await Network().getpassedData(data, "booking/${id}/end");
    body = json.decode(res.body);
    // ignore: avoid_print
    print("body");
    print(body);
    if (res.statusCode == 200) {
      return body["success"].toString();
    } else {
      throw Exception('Failed to send  Mesaage');
    }
  }

  static Future<List<GetPenalties>> getmypenality() async {
    res = await Network().getData("my-penalties");
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => GetPenalties.fromJson(e))
          .toList()
          .cast<GetPenalties>();
    } else {
      throw Exception('Failed to load Comment');
    }
  }

  static Future<Myaccount> getmyaacount() async {
    res = await Network().getData("my-account");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return Myaccount.fromJson(body["data"]);
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<String> otp(var data) async {
    List<String> errors = [];
    // create multipart request
    res = await Network().getpassedData(data, "verify-account");

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
}
