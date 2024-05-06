import 'dart:convert';

import 'package:http/http.dart';
import 'package:weatherapp/constant/weather_constant.dart';
import 'package:weatherapp/model/weather_model.dart';

class ApiService{

  Future<WeatherModel> getData(String searchData)async{
    String url = "$base_url&q=$searchData&days=7";

    try{
      Response response =await get(Uri.parse(url));

      if(response.statusCode == 200){
        Map<String,dynamic> json = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(json);

        return weatherModel;

      }else{
         throw Exception();
      }

    }catch(e){
      throw e.toString();
    }
  }
}