import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app_with_bloc/bloc/weather_bloc.dart';
import 'package:weather_app_with_bloc/components/main_screen_wrapper.dart';
import 'package:weather_app_with_bloc/delegates/search_delegate.dart';
import 'package:weather_app_with_bloc/events/weather_event.dart';
import 'package:weather_app_with_bloc/states/weather_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(primaryColor: Colors.white, primaryColorDark: Colors.white),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc('Berlin'),
      child: BlocBuilder(
        builder: (context, state) {
          if (state is WeatherLoadSuccess) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                actions: [
                  IconButton(
                    icon: Icon(Icons.my_location),
                    onPressed: () {
                      BlocProvider.of<WeatherBloc>(context).add(WeatherCurrentPositionRequested());
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        showSearch(
                            context: context,
                            delegate: MySearchDelegate((query) {
                              BlocProvider.of<WeatherBloc>(context)
                                  .add(WeatherRequested(city: query));
                            }));
                      },
                      icon: Icon(Icons.search))
                ],
              ),
              body: Padding(
                padding: EdgeInsets.only(top: 64),
                child: MainScreenWrapper(
                  weather: state.weather,
                  hourlyWeather: state.hourlyWeather,
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
