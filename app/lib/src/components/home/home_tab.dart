import 'package:flutter/material.dart';
import 'package:ootd/src/components/home/weather_info.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: const [
        DateDisplay(),
        WeatherDisplay(),
      ]),
    );
  }
}
