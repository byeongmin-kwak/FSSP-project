import 'package:flutter/material.dart';
import 'package:FSSP_cilent/screens/home_screen.dart';
import 'package:FSSP_cilent/screens/map_screen.dart';
import 'package:FSSP_cilent/screens/favorite_screen.dart';

class BottomNavWidget extends StatefulWidget {
  final int initialIndex;

  const BottomNavWidget({super.key, required this.initialIndex});

  @override
  _BottomNavWidgetState createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    const MapScreen(),
    const FavoriteScreen(),
    //ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    if (index != 3) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: GlobalKey<NavigatorState>(),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (context) => _widgetOptions[_selectedIndex],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded),
            label: '리뷰지도',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '관심건물',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '내정보',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
