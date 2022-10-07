import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    this.fabLocation = FloatingActionButtonLocation.endDocked,
    this.shape = const CircularNotchedRectangle(),
  });

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;

  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: shape,
      child: Row(children: <Widget>[
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ]),
    );
  }
}
