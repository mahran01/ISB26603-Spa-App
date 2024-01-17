import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/services/facialbook_service.dart';
import 'package:spa_app/services/user_service.dart';
import 'package:spa_app/views/admin/admin_add_user_page.dart';
import 'package:spa_app/views/admin/admin_bottom_nav.dart';
import 'package:spa_app/views/admin/admin_update_profile_page.dart';
import 'package:spa_app/views/login_page.dart';
import 'package:spa_app/views/signup_page.dart';
import 'package:spa_app/views/user/user_booking_page.dart';
import 'package:spa_app/views/user/user_bottom_navigation.dart';
import 'package:spa_app/views/welcome_page.dart';

class RouteManager {
  static void welcome(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomePage(),
      ),
    );
  }

  static void login(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  static void signup(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      ),
    );
  }

  static void userHome(context, {bool replace = false, int initialIndex = 0}) {
    if (replace) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              UserBottomNavigation(initialIndex: initialIndex),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              UserBottomNavigation(initialIndex: initialIndex),
        ),
      );
    }
  }

  static void adminHome(context, {bool replace = false, int initialIndex = 0}) {
    if (replace) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AdminBottomNav(initialIndex: initialIndex),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminBottomNav(initialIndex: initialIndex),
        ),
      );
    }
  }

  static void booking(
    context, {
    void Function()? onComplete,
    int? selectedIndex,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserBookingPage(
            onComplete: onComplete, selectedIndex: selectedIndex),
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

  static void adminAddUser(
    context, {
    void Function()? onComplete,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminAddUserPage(onComplete: onComplete),
      ),
    );
  }

  static void logout(BuildContext context, {int? selectedIndex}) {
    context.read<UserService>().logout();
    context.read<FacialBookService>().unbind();
    Navigator.pushReplacementNamed(context, "/welcome");
  }

  static LoginPage loginPage() => const LoginPage();
  static SignUpPage signUpPage() => const SignUpPage();
  static AdminBottomNav adminHomePage() => const AdminBottomNav();
  static UserBottomNavigation userHomePage() => const UserBottomNavigation();

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      "/welcome": (context) => const WelcomePage(),
      "/login": (context) => const LoginPage(),
      "/signup": (context) => const SignUpPage(),
    };
  }
}
