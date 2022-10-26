import 'package:ootd/src/app.dart';
import 'package:ootd/src/auth/auth.dart';

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
          ElevatedButton(onPressed: _signOut, child: const Icon(Icons.logout)),
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
            builder: (context) => const CameraScreen(),
          ),
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
