import 'package:flutter/material.dart';
import 'package:ootd/src/auth/auth.dart';
import 'package:ootd/src/navigation/capture/camera_page.dart';
import 'package:ootd/src/navigation/factory/wardrobe_factory.dart';
import 'package:intl/intl.dart';
import 'package:open_weather_client/open_weather.dart';
import 'package:open_weather_client/widgets/weather_widget_by_zip_code.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  //List of pages accesible from home screen.
  static const List<Widget> _homePages = <Widget>[
    Center(child: Text('calendar')),
    Center(child: Text('home')),
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController(initialPage: 1);

  Future<void> _signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OOTD'),
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        actions: <Widget>[
          ElevatedButton(
            child: const Icon(Icons.checkroom_outlined),
            onPressed: () {
              Navigator.pushNamed(
                context,
                WardrobeFactory.routeName,
              );
            },
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: _signOut,
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        allowImplicitScrolling: true,
        pageSnapping: false,
        children: HomePage._homePages,
      ),
      floatingActionButton: const CameraActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _BottomNavBar(
        pageController: pageController,
      ),
    );
  }
}

class CameraActionButton extends StatelessWidget {
  const CameraActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'Camera',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CameraScreen(display: true),
          ),
        ).then(
          (value) {
            if (value != null) {}
          },
        );
      },
      tooltip: 'Add Outfit',
      child: const Icon(Icons.photo_camera),
    );
  }
}

class _BottomNavBar extends StatefulWidget {
  const _BottomNavBar({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  State<_BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<_BottomNavBar> {
  void _onNavItemTapped(int index) {
    widget.pageController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: _onNavItemTapped,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 10,
      iconSize: 30,
      currentIndex: widget.pageController.page?.toInt() ?? 1,
      items: [
        historyNavButton(),
        homeNavButton(),
      ],
    );
  }

  BottomNavigationBarItem homeNavButton() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'home',
    );
  }

  BottomNavigationBarItem historyNavButton() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.history_outlined),
      activeIcon: Icon(Icons.history),
      label: 'history',
    );
  }
}

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
      weatherUnits: WeatherUnits.IMPERIAL,
      color: Colors.black,
    );
  }
}
