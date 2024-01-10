import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/models/admin.dart';
import 'package:spa_app/services/user_service.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Admin admin = context.read<UserService>().getCurrentAdmin!;
    String adminid, username, password;
    adminid = admin.adminid.toString();
    username = admin.username;
    password = admin.password;

    return Scaffold(
        appBar: AppBar(
          title: Text('Admin Home'),
        ),
        body: Column(
          children: [
            Text("User ID: $adminid"),
            Text("Username: $username"),
            Text("Password: $password"),
          ],
        ));
  }
}
