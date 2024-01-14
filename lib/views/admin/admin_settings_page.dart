import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/components/table_profile.dart';
import 'package:spa_app/config/routes/route_manager.dart';
import 'package:spa_app/models/admin.dart';
import 'package:spa_app/services/user_service.dart';
import 'package:spa_app/views/admin/admin_update_profile_page.dart';
import 'package:spa_app/views/user/update_profile.dart';
import 'package:spa_app/views/welcome_page.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({super.key});

  @override
  State<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  @override
  Widget build(BuildContext context) {
    Admin admin = context.read<UserService>().getCurrentAdmin!;
    String adminid, username, password;
    adminid = admin.adminid.toString();
    username = admin.username;
    password = "•" * admin.password.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("images/profleimage.png"),
              ),
              title: Text(
                "Admin Profile",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
              subtitle: Text("Your profile"),
            ),
            ProfileTable(
              data: {
                'Admin ID': adminid,
                'Username': username,
                'Password': password,
              },
            ),
            Divider(height: 40),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const AdminUpdateProfilePage(),
                  ),
                ).then((result) {
                  if (result == "OK") {
                    setState(() {});
                  }
                });
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
