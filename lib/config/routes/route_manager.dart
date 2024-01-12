import 'package:flutter/material.dart';
import 'package:spa_app/views/admin/admin_home_page.dart';
import 'package:spa_app/views/login_page.dart';
import 'package:spa_app/views/signup_page.dart';
import 'package:spa_app/views/user/booking_page.dart';
import 'package:spa_app/views/user/bottom_navigation.dart';

class RouteManager {
  static void login(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  static void signup(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      ),
    );
  }

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

  static void booking(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BookingPage(),
      ),
    );
  }

  static LoginPage loginPage() => const LoginPage();
  static SignUpPage signUpPage() => const SignUpPage();
  static AdminHomePage adminHomePage() => const AdminHomePage();
  static BottomNavigation userHomePage() => const BottomNavigation();
  static BookingPage bookingPage() => const BookingPage();
}
