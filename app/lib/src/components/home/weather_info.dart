import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_weather_client/open_weather.dart';
import 'package:open_weather_client/widgets/weather_widget_by_zip_code.dart';

class DateDisplay extends StatefulWidget {
  const DateDisplay({super.key});

  @override
  State<DateDisplay> createState() => _DateDisplayState();
}

class _DateDisplayState extends State<DateDisplay> {
  @override
  Widget build(BuildContext context) {
    final String currentDate =
        DateFormat('EEEE, MMM dd').format(DateTime.now());
    //format date to display "Day of the Week, Month name and the date"
    return Text(currentDate);
  }
}

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
      weatherUnits: WeatherUnits.STANDARD,
      color: Colors.black,
    );
  }
}
