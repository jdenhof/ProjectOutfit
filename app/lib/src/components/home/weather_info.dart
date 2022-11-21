import 'package:flutter/material.dart';
import 'package:open_weather_client/open_weather.dart';
import 'package:open_weather_client/widgets/weather_widget_by_zip_code.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:geolocator/geolocator.dart';

class WeatherDisplay extends StatefulWidget {
  const WeatherDisplay({super.key});

  @override
  State<WeatherDisplay> createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay> {
  String key = '654ee447a45eb25a9a51f53f8a4d693e';
  int zip = 49505;
  String country = 'US';
  @override
  Widget build(BuildContext context) {
    return OpenWeatherByZipCode(
      apiKey: key,
      zipCode: zip,
      countryCode: country,
      weatherUnits: WeatherUnits.IMPERIAL,
      color: Colors.grey,
    );
  }
}
