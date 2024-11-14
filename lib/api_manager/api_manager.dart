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
      var response = await dio.post('$authUrl/register',data: formField);
      print(jsonDecode(response.data));
      print(response.statusMessage);
    }catch(e){
      print("Registration error\n");
      return false;
    }

    return true;
  }

  Future<bool> login(String username, dynamic password) async {
    final String data = jsonEncode({
      'username':username,
      'password' : password
    });

    try{
      var response = await dio.post('$authUrl/login/',data: data);
      print(response.statusMessage);

    }catch(e){
      print("Error logging in");
    }

    return false;
  }

  Future<dynamic> getRecipeInfo(String recipeId) async{
    try{
      var response = await dio.get("$foodUrl/recipeInfo/$recipeId");
      return jsonDecode(response.data);

    }catch(e){
      print("error getting recipe information\n");
    }
    return null;
  }

  Future<dynamic> searchBySubRegion(String subRegion) async {
    try{
      var response = await dio.get("$foodUrl/search_subregion/$subRegion");
      return jsonDecode(response.data);
    }catch(e){
      print("error searching by subregion");
    }

    return null;
  }

  Future<dynamic> searchByRegion(String region) async {
    try{
      var response = await dio.get("$foodUrl/search_region/$region");
      return jsonDecode(response.data);
    }catch(e){
      print("error searching by region");
    }

    return null;
  }

  Future<dynamic> getIngredientsByRecipe(String recipeId) async {

    try{
      var response = await dio.get("$foodUrl/getingredientsbyrecipe/$recipeId");
      //TODO parse the response sting to just return the ingredient names from all the json mumbo jumbo
      return jsonDecode(response.data);
    }catch(e){
      print("Error get ingredients\n");
      
    }

    return null;
  }

  Future<dynamic> recipeOfTheDay() async{
    try{
      var response = await dio.get("$foodUrl/recipeoftheday/");
      return jsonDecode(response.data);
    }catch(e){
      print("error getting recipe of the day");
    }

    return null;
  }

  Future<dynamic> instructions(String recipeId) async {

    try{
      var response = await dio.get("$foodUrl/instructions/$recipeId");
      return jsonDecode(response.data);
    }catch(e){
      print("Error fetching ingredients");
    }

    return null;
  }

  Future<dynamic> similarRecipesProcess(String recipeId) async {
    try{
      var response = await dio.get("$foodUrl/similarrecipespro/$recipeId");
      return jsonDecode(response.data);
    }catch(e){
      print("Error getting similar recipes");
    }

    return null;
  }

  Future<dynamic> similarRecipesCategory(String recipeId) async {
    try{
      var response = await dio.get("$foodUrl/similarrecipescat/$recipeId");
      return jsonDecode(response.data);
    }catch(e){
      print("Error getting similar recipes - 2");
    }

    return null;
  }

  Future<dynamic> searchRecipe(Map<String,String> params) async{
    var request_str = "";
    
    for(MapEntry e in params.entries){
      request_str += "${e.key}=${e.value}";
    }

    try{
      var response = await dio.get("$foodUrl/searchrecipe?$request_str");
      return jsonDecode(response.data);
    }catch(e){
      print("Error searching for recipes");
    }

    return null;
  }

  Future<dynamic> searchIngredient(String name) async {
    try{
      var response = await dio.get("$foodUrl/searchingredientinrecipes/$name");
      return jsonDecode(response.data);
    }catch(e){
      print("Error searching for ingredient");
    }

    return null;
  }
  
  Future<dynamic> searchIngredientNutrition(String name) async {
    try{
      var response = await dio.get("$foodUrl/searchingredientnutrition/$name");
      return jsonDecode(response.data);
    }catch(e){
      print("Error getting ingredient nutrition");
    }

    return null;
  }

  


}