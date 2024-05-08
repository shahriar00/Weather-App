import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/service/api_service.dart';
import 'package:weatherapp/widgets/hourly_basis.dart';
import 'package:weatherapp/widgets/today_weather.dart';

import '../widgets/forecast_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final _textFieldController = TextEditingController();
  String queryText = "auto:ip";

  _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Search Location'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "search by city,zip"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    if (_textFieldController.text.isEmpty) {
                      return;
                    }
                    Navigator.pop(context, _textFieldController.text);
                  }),
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        actions: [ 
           IconButton(
              onPressed: () async {
                _textFieldController.clear();
                String text = await _showTextInputDialog(context);
                setState(() {
                  queryText = text;
                });
              },
              icon: const Icon(Icons.search,color: Colors.white,)),
          IconButton(
              onPressed: () {
                setState(() {
                  queryText = "auto:ip";
                });
              },
              icon: const Icon(Icons.my_location,color: Colors.white,)),
        ],
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "Weather App",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: apiService.getData(queryText),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  WeatherModel? weatherModel = snapshot.data;

                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        TodayWeather(
                          weatherModel: weatherModel,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Weather by Hours",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: weatherModel
                                  ?.forecast?.forecastday?[0].hour?.length,
                              itemBuilder: (context, index) {
                                Hour? hour = weatherModel
                                    ?.forecast?.forecastday?[0].hour?[index];
                                return HourlyWeatherListItem(
                                  hour: hour,
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "7 days Forecast",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount:
                                  weatherModel?.forecast?.forecastday?.length,
                              itemBuilder: (context, index) {
                                Forecastday? forecastday =
                                    weatherModel?.forecast?.forecastday![index];
                                return FutureForcastListItem(
                                  forecastday: forecastday,
                                );
                              }),
                        ),

                         const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error has Occured"),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              })),
    );
  }
}
