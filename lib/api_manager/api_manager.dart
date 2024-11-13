import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';

class ApiManager {
  final dio = Dio();

  var foodUrl = "https://cosylab.iiitd.edu.in/api/recipeDB";
  var authUrl = "https:/suggondeeznuts.com";

  Future<bool> register(String email ,String mobile, String password) async {

    final String formField = jsonEncode({
      'email':email,
      'mobile': mobile,
      'password': password
    });

    try{
      var response = await dio.post(authUrl + '/register',data: formField);
      print(json.decode(response.data));
      print(response.statusMessage);
    }catch(e){
      print("Registration error\n");
      return false;
    }

    return true;
  }

  Future<bool> login(String username, dynamic password) async {
    final String data = json.encode({
      'username':username,
      'password' : password
    });

    try{
      var response = await dio.post(authUrl + '/login/',data: data);
      print(response.statusMessage);

    }catch(e){
      print("Error logging in");
    }

    return false;
  }

  Future<String> getRecipeInfo(String recipeId) async{
    final String endpoint = "/recipeInfo/$recipeId";
    try{
      var response = await dio.get(foodUrl+endpoint);
      return json.decode(response.data);
    }catch(e){
      print("error getting recipe information\n");
    }
    return "Error getting recipe info";
  }

  Future<String> searchBySubRegion(String subRegion) async {
    final String endpoint = "/search_subregion/$subRegion";
    try{
      var response = await dio.get(foodUrl+endpoint);
      return json.decode(response.data);
    }catch(e){
      print("error searching by subregion");
    }

    return "";
  }

  Future<String> searchByRegion(String region) async {
    final String endpoint = "/search_region/$region";

    try{
      var response = await dio.get(foodUrl+endpoint);
      return json.decode(response.data);
    }catch(e){
      print("error searching by region");
    }

    return "";
  }

  


}