import 'package:flutter/material.dart';
import 'package:open_weather_client/open_weather.dart';
import 'package:open_weather_client/widgets/weather_widget_by_zip_code.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:geolocator/geolocator.dart';

//Keeping as failsafe in case new eather widget does not work
class WeatherDisplay extends StatefulWidget {
  const WeatherDisplay({super.key});

  @override
  State<WeatherDisplay> createState() => _WeatherDisplayState();
}

/*class _WeatherDisplayState extends State<WeatherDisplay> {
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
}*/

//Need to find appropriate dependency
// step 1. Get location coordinates
/*class Location {
  double latitude;
  double longitide;
  String apiKey = '654ee447a45eb25a9a51f53f8a4d693e';
  int status;

  /// async and await are used for time consuming tasks
  /// Get your current loatitude and longitude
  /// Location accuracy depends on the type of app high,low ,
  /// high accuracy also result in more power consumed
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      latitude = position.latitude;
      longitide = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}*/

/// step 2. class that Fetch data from API using url
/// weather API network helper
/// pass the weatherAPI url
///  to this class to get geographical coordinates
class NetworkData {
  NetworkData(this.url);
  final String url;

  /// get geographical coordinates from open weather API call
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

/// step 3. call the class that fetches response from API and pass URL
/// we can get data by location coordinates or city name
/// N.B there are many other ways of getting weather data through the url
const weatherApiUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  String apiKey = '654ee447a45eb25a9a51f53f8a4d693e'; //apiKey from Open Weather

  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$weatherApiUrl?q=$cityName&appid=$apiKey&units=metric';
    NetworkData networkHelper = NetworkData(url);
    var weatherData = networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    /// Get location
    /// await for methods that return future
    //Location location = Location();
    //await location.getCurrentLocation();

    //hardcoded laat and long og Mak Hall until location works
    double latitude = 42.966729;
    double longitude = -85.887071;

    /// Get location data
    NetworkData networkHelper = NetworkData(
        '$weatherApiUrl?lat=${latitude}&lon=${longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  /// add appropriete icon to page  according to response from API
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  /*String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }*/
}

class _WeatherDisplayState extends State<WeatherDisplay> {
  void initState() {
    super.initState();
    getLocationData();
  }

  getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Locations(locationWeather: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Text('Loading');
  }
}

class Locations extends StatefulWidget {
  Locations({this.locationWeather});
  final locationWeather;
  @override
  _LocationsState createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  int temperature = 0;
  int condition = 0;
  String cityName = 'Allendale';
  String weatherIcon = '';
  String tempIcon = '';
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weather) {
    setState(() {
      if (weather == null) {
        temperature = 0;
        weatherIcon = 'Error';
        tempIcon = 'Unable to get weather data';
        cityName = '';
        return;
      }
      var condition = weather['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      double temp = weather['main']['temp'];
      temperature = temp.toInt();

      cityName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                      size: 50.0,
                    )),
              ],
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                decoration: textFieldDecoration,
                onChanged: (value) {
                  cityName = value;
                },
              ),
            ),
            TextButton(
              onPressed: () async {
                if (cityName != null) {
                  var weatherData = await weatherModel.getCityWeather(cityName);
                  updateUI(weatherData);
                }
              },
              child: Text(
                'Get Weather',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Row(
                children: <Widget>[
                  Text(
                    '$temperature°  ',
                  ),
                  Text(
                    '$weatherIcon',
                  ),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$tempIcon in $cityName',
                  //textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const textFieldDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    icon: Icon(
      Icons.local_activity,
      color: Colors.white,
    ));
