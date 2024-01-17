import 'package:flutter/material.dart';
import 'package:spa_app/views/user/user_schedule_page.dart';
import 'package:spa_app/views/user/user_home_page.dart';
import 'package:spa_app/views/user/user_settings_page.dart';

class UserBottomNavigation extends StatefulWidget {
  const UserBottomNavigation({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<UserBottomNavigation> createState() => _UserBottomNavigationState();
}

class _UserBottomNavigationState extends State<UserBottomNavigation> {
  int _selectedIndex = 0;

  // 8
  static List<Widget> pages = <Widget>[
    Home(gotoPage: null),
    const UserSchedulePage(),
    const UserSettingsPage(),
  ];

  // 9
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    pages[0] = Home(gotoPage: _onItemTapped);
    _selectedIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: pages[_selectedIndex],
        // 4
        bottomNavigationBar: BottomNavigationBar(
          // 5
          selectedItemColor:
              Theme.of(context).textSelectionTheme.selectionColor,
          // 10
          currentIndex: _selectedIndex,
          // 11
          onTap: _onItemTapped,
          // ignore: prefer_const_literals_to_create_immutables
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: 'Shcedule'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
