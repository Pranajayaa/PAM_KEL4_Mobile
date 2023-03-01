import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jastip/models/Jastip/ModelJastip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/string_http_exception.dart';
import '../url_api.dart';


class JastipData with ChangeNotifier{
  List<ModelJastip> listJastip = [];
  List<ModelJastip> listJastipById = [];
  bool? statPost = false;
  bool? statDelete = false;

  Future<void> getJastip()async{
    String url = UrlApi().getJastip;
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final responseData = json.decode(response.body);
        final datah = responseData['data'];
        Iterable data = datah;
        listJastip = data.map((e) => ModelJastip.fromJson(e)).toList();
      }else{
        throw StringHttpException("Something Went Wrong !");
      }
    }catch(e){
      rethrow;
    }
  }

  Future<void> postJastip(String categoryId, providerName, name, description,
      stock, temporaryStock, waAdmin, List<XFile> image, id)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id2 = prefs.getInt("id").toString();
    try{
      final url = id == "0"
                  ? UrlApi().createJastip
                  : UrlApi().editJastip + id;
      final uri = Uri.parse(url);
      print(url);
      var request = id == "0"
                    ? http.MultipartRequest('POST', uri)
                    : http.MultipartRequest('PUT', uri);
      for (int i = 0; i < image.length; i++) {
        var pic = await http.MultipartFile.fromPath("images[$i]", image[i].path);
        request.files.add(pic);
      }
      request.fields['category_id'] = categoryId;
      request.fields['provider_name'] = providerName;
      request.fields['name'] = name;
      request.fields['description'] = description;
      request.fields['stock'] = stock;
      request.fields['temporary_stock'] = temporaryStock;
      request.fields['status'] = "1";
      request.fields['wa_admin'] = waAdmin;
      if(id == "0"){
        request.fields['created_by'] = id2;
      }else{
        request.fields['edited_by'] = id2;
      }
      var respon = await request.send();
      var responStatus = await respon.stream.toBytes();
      var responString = String.fromCharCodes(responStatus);
      print(responString);
      final responseData = json.decode(responString);
      if(responseData['success'] == true){
        statPost = true;
      }else{
        statPost = false;
      }

    }catch(e){
      rethrow;
    }

  }

  Future<void> getJastipById(String id)async{
    String url = UrlApi().getJastipById + id;
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final responseData = json.decode(response.body);
        final datah = responseData['results'];
        Iterable data = datah;
        listJastip = data.map((e) => ModelJastip.fromJson(e)).toList();
      }else{
        throw StringHttpException("Something Went Wrong !");
      }
    }catch(e){
      rethrow;
    }
  }

  Future<void> deleteJastip(String id)async{
    String url = UrlApi().deleteJastip + id;
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