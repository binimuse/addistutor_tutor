import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path/path.dart';

class Network {
  final String _url = 'https://tutor.oddatech.com/api/';
  // ignore: prefer_typing_uninitialized_variables
  var token;

  _setFileHeaders() => {
        'Content-type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    token = localStorage.getString('token');
    // print(token);
    // print("token");
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);

    await _getToken();
    // ignore: avoid_print

    return await http.get(uri, headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  getpassedData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);

    await _getToken();
    return await http.post(uri, body: jsonEncode(data), headers: _setHeaders());
  }

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);
    return await http.post(uri, body: jsonEncode(data), headers: _setHeaders());
  }

  uploadFile(apiUrl, file, stream, length) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);
    await _getToken();
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(_setFileHeaders());

    var multipartFile = http.MultipartFile('image', stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
    return await request.send();
  }

  // uploadFilewallet(apiUrl, file, data, stream, length) async {
  //   var fullUrl = _url + apiUrl;
  //   var uri = Uri.parse(fullUrl);
  //   await _getToken();
  //   var request = http.MultipartRequest("POST", uri);
  //   request.headers.addAll(_setFileHeaders());

  //   var multipartFile = http.MultipartFile('image', stream, length,
  //       filename: basename(file.path));
  //   request.files.add(multipartFile);
  //   return await request.send();
  // }

  postFile2(apiUrl, file, data, stream, length) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);
    await _getToken();
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(_setFileHeaders());
    request.fields["amount"] = data["amount"].toString();
    request.fields["slip_id"] = data["slip_id"].toString();

    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
    return await request.send();
  }
}
