import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

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
    return Text(
      currentDate,
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
    );
  }
}
