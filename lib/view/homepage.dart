import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/service/api_service.dart';
import 'package:weatherapp/widgets/today_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Colors.green,
        title: const Text("Weather App",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.normal),),
        centerTitle: true,
      ),

      body: SafeArea(child:  FutureBuilder(future: apiService.getData("Dhaka"), builder: (context,snapshot){
        if(snapshot.hasData){
          WeatherModel? weatherModel = snapshot.data;

          return TodayWeather(weatherModel: weatherModel,);


        }
        if(snapshot.hasError){
          return const Center(child: Text("Error has Occured"),);
        }

        return const Center(child: CircularProgressIndicator(),);
      })),
    );
  }
}