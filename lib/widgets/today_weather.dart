import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/weather_model.dart';

class TodayWeather extends StatelessWidget {
  WeatherModel? weatherModel;
  TodayWeather({super.key,required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [ 
        WeatherBg(weatherType: WeatherType.sunnyNight, width: double.infinity, height: 300),

        SizedBox(width: double.infinity,
        height: 300,
        child: Column(
          children: [
            Text(weatherModel?.location?.name ?? "",style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),


            Text(DateFormat.yMMMMEEEEd().format(DateTime.parse(weatherModel?.location?.localtime ?? "")),style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          ],
        ),)
      ],
    );
  }
}