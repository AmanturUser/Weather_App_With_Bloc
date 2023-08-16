import 'package:flutter/material.dart';
import 'package:weather_app_with_bloc/components/weather_card.dart';
import 'package:weather_app_with_bloc/components/weather_hours.dart';
import 'package:weather_app_with_bloc/models/Weather.dart';

class MainScreenWrapper extends StatelessWidget {
  final Weather weather;
  final List<Weather> hourlyWeather;

  const MainScreenWrapper(
      {super.key, required this.weather, required this.hourlyWeather});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            weather.cityName,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(weather.description),
          Spacer(),
          WeatherCard(
              title: 'Now',
              iconCode: weather.iconCode,
              temperature: weather.temperature,
              iconScale: 1,
              temperatureFontSize: 64),
          Spacer(),
          HourlyWeather(hourlyWeather: hourlyWeather)
        ],
      ),
    );
  }
}
