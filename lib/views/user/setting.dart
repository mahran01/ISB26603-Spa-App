import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/components/table_profile.dart';
import 'package:spa_app/config/routes/route_manager.dart';
import 'package:spa_app/models/user.dart';
import 'package:spa_app/services/user_service.dart';
import 'package:spa_app/views/user/update_profile.dart';
import 'package:spa_app/views/welcome_page.dart';
import 'package:spa_app/components/table_profile.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

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
        title: Text('Setting'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("images/profleimage.png"),
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
              subtitle: const Text("Your profile"),
            ),
            ProfileTable(
              data: {
                'Name': name,
                'Email': email,
                'Phone': phone,
                'Username': username,
              },
            ),
            Divider(height: 40),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpdateProfile(),
                  ),
                );
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.update,
                  color: Colors.blue,
                  size: 35,
                ),
              ),
              title: Text(
                "Update Profile",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            Divider(height: 40),
            ListTile(
              onTap: () => RouteManager.logout(context),
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.redAccent.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout_outlined,
                  color: Colors.black,
                  size: 35,
                ),
              ),
              title: Text(
                "Log Out",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
