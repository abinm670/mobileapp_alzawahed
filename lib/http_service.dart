import 'dart:convert';
import 'package:attend/auth/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:attend/auth/globallvariable.dart' as globals;

class HttpService {
  static final _client = http.Client();
  // ignore: prefer_final_fields
  static var _sendlocationurl =
      Uri.parse('https://secguardssys.com/app_attendance');
  // ignore: prefer_final_fields
  //https://51.211.168.27/loginapp
  //https://secguardssys.com/loginapp
   static var _loginUrl = Uri.parse('https://secguardssys.com/loginapp');
  //static var _loginUrl = Uri.parse('http://localhost:5000/loginapp');
  // ignore: prefer_final_fields
  static var deleteuserUrl = Uri.parse('https://secguardssys.com/deleteuser');
  static deleteuse(userid, context) async {
    try {
      http.Response response = await _client.post(deleteuserUrl, body: {
        "userid": userid.toString(),
      });

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json[0] == 'success') {
          globals.userId = json[1];
          globals.userName = json[2];
          await EasyLoading.showSuccess("تم الحذف بنجاح");
          await Navigator.of(context).pushReplacementNamed("login");
        } else {
          EasyLoading.showError("تم الحذف");
        }
      } else {
        await EasyLoading.showError(
            "Error Code : ${response.statusCode.toString()}");
      }
    } finally {}
  }

  static var _registerUrl =
      Uri.parse('https://secguardssys.com/registrationapp');

  static login(username, password, context) async {
    try {
      http.Response response = await _client.post(_loginUrl, body: {
        "username": username,
        "password": password,
      });

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json[0] == 'success') {
          globals.userId = json[1];
          globals.userName = json[2];
          globals.period = json[3];
         // globals.period = 20;
       
          await EasyLoading.showSuccess(json[0]);
          await Navigator.of(context).pushReplacementNamed("homepage");
        } else {
          EasyLoading.showError("تاكد من صحة بيانات الدخول");
        }
      } else {
        await EasyLoading.showError(
            "Error Code : ${response.statusCode.toString()}");
      }
    } finally {}
  }

//end
  static sendlocation(lat, lon, outt, id, auto) async {
    try {
      final response = await http.post(_sendlocationurl,
          body: json.encode({'lat': lat, 'lon': lon, 'outt': outt, 'id': id}));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json == 'success') {
            if (auto == 0) {
              await EasyLoading.showSuccess(json as String);
            }
          // await Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => const homePage()));
        } else {
          EasyLoading.showError(json as String);
        }
      } else {
        await EasyLoading.showError(
            "Error Code : ${response.statusCode.toString()}");
      }
    } finally {
      _client.close();
    }
  }

  static register(userName, email, password, context) async {
    try {
      http.Response response = await _client.post(_registerUrl, body: {
        "email": email,
        "password": password,
        "userName": userName,
      });

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json[0] == 'exisist') {
          await EasyLoading.showError("Error Code 01 : ${json[0]}");
        } else {
          await EasyLoading.showSuccess("تم بنجاح");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => loginPage()));
        }
      } else {
        var json = jsonDecode(response.body);
        await EasyLoading.showError("Error Code 03 : ${json[0]}");
      }
    } finally {
      await EasyLoading.showSuccess(" تم انشاء الحساب بنجاح ");
      // _client.close();
    }
  }
}
