import 'package:flutter/material.dart';
import 'package:weather_app_with_bloc/components/weather_card.dart';

import '../models/Weather.dart';

class HourlyWeather extends StatelessWidget {
  final List<Weather> hourlyWeather;
  const HourlyWeather({super.key,required this.hourlyWeather});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hourlyWeather.length,
        itemBuilder: (context,index){
          return WeatherCard(
            title: '${hourlyWeather[index].time.hour}: ${hourlyWeather[index].time.minute}',
            temperature: hourlyWeather[index].temperature.toInt(),
            iconCode: hourlyWeather[index].iconCode,
            temperatureFontSize: 20,
          );
        },
      ),
    );
  }
}
