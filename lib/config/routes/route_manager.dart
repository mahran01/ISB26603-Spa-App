import 'package:flutter/material.dart';
import 'package:spa_app/views/admin/admin_home_page.dart';
import 'package:spa_app/views/user/bottom_navigation.dart';

class RouteManager {
  static void adminHome(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminHomePage(),
      ),
    );
  }

  static void userHome(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigation(),
      ),
    );
  }
}
