

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jastip/models/Customer/modelCustomer.dart';
import 'package:http/http.dart' as http;
import '../../models/string_http_exception.dart';
import '../url_api.dart';

class Customers with ChangeNotifier{
  List<ModelCustomer> listCostumer = [];


  Future<void> getCustomer()async{
    String url = UrlApi().getCustomer;
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final responseData = json.decode(response.body);
        final datah = responseData['data'];
        Iterable data = datah;
        listCostumer = data.map((e) => ModelCustomer.fromJson(e)).toList();
      }else{
        throw StringHttpException("Something Went Wrong !");
      }
    }catch(e){
      rethrow;
    }
  }

}