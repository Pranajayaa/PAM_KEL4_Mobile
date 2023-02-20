import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/User/ModelUserLogin.dart';
import '../../models/string_http_exception.dart';
import '../url_api.dart';

class Auth with ChangeNotifier{
  bool loginUser = false;
  bool registerSucces = false;
  String messageRegist = "";

  Future<void> authenticate(String username, String password)async{
    String url = UrlApi().login;
    try{
      print(url);
      final response = await http.post(
          Uri.parse(url),
          body: {
            "username" : username,
            "password" : password,
          }
      );
      final responseData = json.decode(response.body);
      int? code = responseData['code'];
      print(responseData);
      if(code != 200){
        loginUser = false;
        throw StringHttpException(responseData['message']);
      }else {
        final data = responseData['data'][0];
        loginUser = true;
        int id = data['id'];
        String username = data['username'];
        String email = data['email'];
        String loginStatus = 'success';
        sharedPref(id, username, email, loginStatus);
      }
    }catch(e, stackTrace){
      rethrow;
    }

  }

  Future<void> register(String username, String password, String name, String email, String phone)async{
    String url = UrlApi().register;
    try{
      final response = await http.post(
          Uri.parse(url),
          body: {
            "username" : username,
            "password" : password,
            "name" : name,
            "email" : email,
            "phone" : phone,
          }
      );
      final responseData = json.decode(response.body);
      int? code = responseData['code'];
      if(code != 200){
        registerSucces = false;
        throw StringHttpException(responseData['message']);
      }else {
        registerSucces = true;
        messageRegist = responseData['message'];

      }
    }catch(e, stackTrace){
      rethrow;
    }

  }

  Future<UserLogin> users(String? id)async{
    String url = UrlApi().getUserById + id!;
    print(url);
    try{
      final response = await http.get(Uri.parse(url));
      print(response.body);
      if(response.statusCode == 200){
        final responseData = json.decode(response.body);
        UserLogin user = UserLogin.fromJson(responseData);
        return user;
      }else{
        return UserLogin();
      }
    }catch(e){
      rethrow;
    }

  }

}

sharedPref(int id, String username, String email, loginStatus)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt("id", id);
  prefs.setString("username", username);
  prefs.setString("email", email);
  prefs.setString("loginStatus", loginStatus);
}