import 'package:flutter/material.dart';
import 'calendar_page.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.fabLocation,
    required this.shape,
  });

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape shape;
  final double _iconSize = 40;

  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  void _navigateToCalendar(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const CalendarPage(title: 'Calendar')));
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: shape,
      child: Row(children: <Widget>[
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.date_range),
          iconSize: _iconSize,
          onPressed: () {
            _navigateToCalendar(context);
          },
        ),
        const Spacer(),
        const Spacer(),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.checkroom),
          iconSize: _iconSize,
          onPressed: () {},
        ),
        const Spacer(),
      ]),
    );
  }
}
