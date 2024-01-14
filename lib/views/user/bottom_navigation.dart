import 'package:flutter/material.dart';
import 'package:spa_app/models/treatment.dart';
import 'package:spa_app/views/user/booked_schedule.dart';
import 'package:spa_app/views/user/home.dart';
import 'package:spa_app/views/user/setting.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  // 8
  static List<Widget> pages = <Widget>[
    Home(gotoPage: null),
    const SchedulePage(),
    const Setting(),
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
                icon: Icon(Icons.settings), label: 'Setting'),
          ],
        ),
      ),
    );
  }
}
