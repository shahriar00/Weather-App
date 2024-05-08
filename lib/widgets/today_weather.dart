import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/weather_model.dart';

class TodayWeather extends StatelessWidget {
  WeatherModel? weatherModel;
  TodayWeather({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        WeatherBg(
            weatherType: WeatherType.sunnyNight,
            width: double.infinity,
            height: 300),
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Column(
            children: [
              Text(
                weatherModel?.location?.name ?? "",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat.yMMMMEEEEd().format(DateTime.parse(
                    weatherModel?.current?.lastUpdated.toString() ?? "")),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white10, shape: BoxShape.circle),
                    child: Center(
                      child: Image.network(
                        weatherModel?.current?.condition?.icon ?? '',
                        scale: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth / 1.90,
                  ),
                  Text(
                    weatherModel?.current?.tempC?.round().toString() ?? '',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 80,
                        fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 50, left: 5),
                    child: Text(
                      "o",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Feels Like",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          weatherModel?.current?.feelslikeC
                                  ?.round()
                                  .toString() ??
                              '',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Wind      ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          weatherModel?.current?.windKph?.round().toString() ??
                              '',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Humidity",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          weatherModel?.current?.humidity.toString() ?? '',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Visibility",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          weatherModel?.current?.visKm?.round().toString() ??
                              '',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
