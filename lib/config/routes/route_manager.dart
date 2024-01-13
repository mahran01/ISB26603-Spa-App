import 'package:flutter/material.dart';
import 'package:spa_app/views/admin/admin_add_user_page.dart';
import 'package:spa_app/views/admin/admin_bottom_nav.dart';
import 'package:spa_app/views/admin/admin_home_page.dart';
import 'package:spa_app/views/admin/admin_update_profile_page.dart';
import 'package:spa_app/views/login_page.dart';
import 'package:spa_app/views/signup_page.dart';
import 'package:spa_app/views/user/booking_page.dart';
import 'package:spa_app/views/user/bottom_navigation.dart';
import 'package:spa_app/views/welcome_page.dart';

class RouteManager {
  static void welcome(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomePage(),
      ),
    );
  }

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

  static void adminHome(context, {int initialIndex = 0}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminBottomNav(initialIndex: initialIndex),
      ),
    );
  }

  static void adminUpdateProfile(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminUpdateProfilePage(),
      ),
    );
  }

  static void adminAddUser(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminAddUserPage(),
      ),
    );
  }

  static void userHome(context, {int initialIndex = 0}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavigation(initialIndex: initialIndex),
      ),
    );
  }

  static void booking(context, {int? selectedIndex}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingPage(selectedIndex: selectedIndex),
      ),
    );
  }

  static LoginPage loginPage() => const LoginPage();
  static SignUpPage signUpPage() => const SignUpPage();
  static AdminHomePage adminHomePage() => const AdminHomePage();
  static BottomNavigation userHomePage() => const BottomNavigation();
  static BookingPage bookingPage() => const BookingPage();
}
