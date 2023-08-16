
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_with_bloc/events/weather_event.dart';
import 'package:weather_app_with_bloc/models/Weather.dart';
import 'package:weather_app_with_bloc/services/weather_service.dart';
import 'package:weather_app_with_bloc/states/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final String cityName;
  WeatherBloc(this.cityName) : super(null) {
    add(WeatherRequested(city: cityName));
  }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherRequested) {
      yield WeatherLoadInProgress();
      try {
        final Weather weather =
        await WeatherService.fetchCurrentWeather(query: event.city);
        final List<Weather> hourlyWeather =
        await WeatherService.fetchHourlyWeather(query: event.city);
        yield WeatherLoadSuccess(
            weather: weather, hourlyWeather: hourlyWeather);
      } catch (_) {
        yield WeatherLoadFailure();
      }
    }
  }

  Stream<WeatherState> _newWeatherRequested(WeatherRequested event) async*{
    yield WeatherLoadInProgress();
    try{
      final Weather weather = await WeatherService.fetchCurrentWeather(
        query: event.city,lon: event.lon,lat: event.lat
      );
      final List<Weather> hourlyWeather= await WeatherService.fetchHourlyWeather(
          query: event.city,lon: event.lon,lat: event.lat
      );
      yield WeatherLoadSuccess(weather: weather, hourlyWeather: hourlyWeather);
    }catch(_){
      yield WeatherLoadFailure();
    }
  }

  Stream<WeatherState> _newWeatherCurrentPositionRequested() async* {
    LocationPermission permission = await checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position lastKnownPosition = await getLastKnownPosition();
      if(lastKnownPosition != null) {
        add(WeatherRequested(
            lat: lastKnownPosition.latitude.toString(),
            lon: lastKnownPosition.longitude.toString()));

      } else {
        Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        add(WeatherRequested(
            lat: position.latitude.toString(),
            lon: position.longitude.toString()));
      }
    } else {
      await requestPermission();
      add(WeatherCurrentPositionRequested());
    }
  }

}