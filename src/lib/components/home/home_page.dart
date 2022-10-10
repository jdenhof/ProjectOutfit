import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:app/components/camera_page/camera.dart';

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
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OOTD'),
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      body: PageView(
        controller: pageController,
        allowImplicitScrolling: false,
        children: HomePage._homePages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await availableCameras().then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CameraScreen(cameras: value)),
              ));
        },
        tooltip: 'Add Outfit',
        child: const Icon(Icons.photo_camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _BottomNavBar(
        pageController: pageController,
      ),
    );
  }
}

class _BottomNavBar extends StatefulWidget {
  const _BottomNavBar({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final FloatingActionButtonLocation fabLocation =
      FloatingActionButtonLocation.centerDocked;
  final NotchedShape shape = const CircularNotchedRectangle();

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
    return Container(
      child: BottomNavigationBar(
        onTap: _onNavItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 10,
        iconSize: 30,
        currentIndex: widget.pageController.page?.toInt() ?? 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'history',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'home',
          ),
        ],
      ),
    );
  }
}
