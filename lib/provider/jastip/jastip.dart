import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jastip/models/Jastip/ModelJastip.dart';
import '../../models/string_http_exception.dart';
import '../url_api.dart';


class JastipData with ChangeNotifier{
  List<ModelJastip> listJastip = [];
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

}