import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';


var dio = Dio();
var headers = {
  'Authorization' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluIn0.x6OxH120iJxLyxEliEXXCocDk5pHxR38PjdCmUJfayQ'
};

Future<dynamic> getCuisine(String country) async{
    var country_ids;

    try{
      var response = await dio.get('http://10.0.2.2:5000/map/$country',options: Options(
        headers: headers
      ));
      country_ids = jsonDecode(response.data);
      print(country_ids);
      return country_ids;

    }catch(e){
      print("Error getting cuisine $e");
    }

    return "recipes";
}

Future<dynamic> getDish(String recipeID) async{
  try{
    var response = await dio.get("http://10.0.2.2:5000/recipe/$recipeID",options: Options(
      headers: headers
    ));
    var result = jsonDecode(response.data);
    print(result);
    return result;

  }catch(e){
    print("Error getting dish $e");
  }

  return "";
}

 Future<dynamic> rotd() async{
  try{
    var response = await dio.get("http://10.0.2.2:5000/rotd",options: Options(
      headers: headers
    ));

    return jsonDecode(response.data);

  }catch(e){
    print("Error $e");
  }
 }

 Future<dynamic> getDishs() async{
  try{
    var response = await dio.get("http://10.0.2.2:5000/dishes/",options: Options(
      headers: headers
    ));

    return jsonDecode(response.data);
  }catch(e){
    print("Error dishes $e");
  }
 }

 Future<dynamic> search(String title) async{
  try{
    var response = await dio.get("http://10.0.2.2:5000/search/$title",options: Options(
      headers: headers
    ));

    return jsonDecode(response.data);
  }catch(e){
    print("Error dishes $e");
  }
 }


 Future<dynamic> adv(String cal) async{
  var data = {
    "energy"  : cal
  };
  try{
    var res = await dio.post("http://10.0.2.2:5000/adv",data:data,options: Options(
      headers: headers
    ));

    return jsonDecode(res.data);
  }catch(e){
    print("Error $e");
  }
 }




