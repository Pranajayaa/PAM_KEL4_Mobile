

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jastip/models/Customer/modelCustomer.dart';
import 'package:http/http.dart' as http;
import '../../models/string_http_exception.dart';
import '../url_api.dart';

class Customers with ChangeNotifier{
  List<ModelCustomer> listCostumer = [];
  bool? statPost = false;
  bool? statDelete = false;

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

  Future<void> postCustomer(String personalShoperId, String name, String phone, String email, String status, id)async{
    String url = id == "0"
              ? UrlApi().createCustomer
              : UrlApi().editCustomer + id;
    try{
      final response = await http.post(
          Uri.parse(url),
        body: {
          "personal_shopper_id" : personalShoperId,
          "name" : name,
          "phone" : phone,
          "email" : email,
          "satatus" : status,
        }
      );
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

  Future<void> deleteCustomer(String id)async{
    String url = UrlApi().deleteCustomer + id;
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