import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/models/user.dart';
import 'package:spa_app/services/user_service.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserService>().getCurrentUser!;
    String userid, name, email, phone, username, password;
    userid = user.userid.toString();
    name = user.name;
    email = user.email;
    phone = user.phone.toString();
    username = user.username;
    password = user.password;

    return Scaffold(
        appBar: AppBar(
          title: Text('User Home'),
        ),
        body: Column(
          children: [
            Text("User ID: $userid"),
            Text("Name: $name"),
            Text("Email: $email"),
            Text("Phone: $phone"),
            Text("Username: $username"),
            Text("Password: $password"),
          ],
        ));
  }
}
