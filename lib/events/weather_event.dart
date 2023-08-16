import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherCurrentPositionRequested extends WeatherEvent {
  const WeatherCurrentPositionRequested() : super();

  @override
  List<Object> get props => [];
}

class WeatherRequested extends WeatherEvent {
  final String city;
  final String lat;
  final String lon;

  const WeatherRequested({this.city = '', this.lat = '', this.lon = ''})
      : assert(city != null);

  @override
  List<Object> get props=>[city];
}
