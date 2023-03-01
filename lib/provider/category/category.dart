import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jastip/models/category/ModelCategory.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/string_http_exception.dart';
import '../url_api.dart';



class CategoryData with ChangeNotifier{
  List<ModelCategory> listCategory = [];
  bool? statPost = false;
  bool? statDelete = false;

  Future<void> getCategory()async{
    String url = UrlApi().getCategory;
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final responseData = json.decode(response.body);
        final datah = responseData['data'];
        Iterable data = datah;
        listCategory = data.map((e) => ModelCategory.fromJson(e)).toList();
      }else{
        throw StringHttpException("Something Went Wrong !");
      }
    }catch(e){
      rethrow;
    }
  }

  Future<void> postCategory(String name, id)async{
    String url = id == "0"
        ? UrlApi().createCategory
        : UrlApi().editCategory + id;
    print(url);
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id2 = prefs.getInt("id").toString();
      final response = await http.post(
          Uri.parse(url),
          body: id == "0"
            ? {
            "name" : name,
            "created_by" : id2
          }
            :{
            "name" : name,
            "edited_by" : id2
          }
      );
      print(response.body);
      if(response.statusCode == 200){
        final responseData = json.decode(response.body);
        if(responseData["success"] == true){
          statPost = true;
        }else{
          statPost = false;
        }

      }else{
        throw StringHttpException("Something Went Wrong !");
      }
    }catch(e){
      rethrow;
    }
  }

  Future<void> deleteCategory(String id)async{
    String url = UrlApi().deleteCategory + id;
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final responseData = json.decode(response.body);
        if(responseData["success"] == true){
          statDelete = true;
        }else{
          statDelete = false;
        }

      }else{
        throw StringHttpException("Something Went Wrong !");
      }
    }catch(e){
      rethrow;
    }
  }
}