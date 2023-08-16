import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String title;
  final int temperature;
  final String iconCode;
  final double temperatureFontSize;
  final double iconScale;

  const WeatherCard(
      {super.key,
      required this.title,
      required this.iconCode,
      required this.temperature,
      this.iconScale=2,
      this.temperatureFontSize=32});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(this.title),
            Image.network(
                "http://openweathermap.org/img/wn/${this.iconCode}@2x.png",
                scale: this.iconScale),
            Text(
              '${this.temperature}°',
              style: TextStyle(
                  fontSize: this.temperatureFontSize,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
