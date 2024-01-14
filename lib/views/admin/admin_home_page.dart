import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/components/admin/user_list.dart';
import 'package:spa_app/components/facial_decoration.dart';
import 'package:spa_app/components/show_snackbar.dart';
import 'package:spa_app/models/admin.dart';
import 'package:spa_app/models/user.dart';
import 'package:spa_app/services/user_service.dart';
import 'package:spa_app/views/admin/admin_add_user_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key, this.gotoPage});

  final void Function(int)? gotoPage;

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  late List<User> userList;
  late List<bool> userSelected;
  late int userCount;

  updateUserList() {
    userList = context.read<UserService>().getAlUser!;
    userSelected = userList.map((e) => false).toList();
    userCount = userList.length;
  }

  @override
  void initState() {
    updateUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Admin admin = context.read<UserService>().getCurrentAdmin!;
    String username;
    username = admin.username;

    final double maxWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Facial Treatment'),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    facial_Decoration(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AdminAddUserPage(onComplete: () => 0)),
                        ).then((result) {
                          setState(() {
                            if (result == "OK") {
                              userList = context.read<UserService>().getAlUser!;
                              updateUserList();
                            }
                          });
                        });
                      },
                      text1: "Add User",
                      text2: "Create a new user",
                      icon: Icons.add,
                      color_shceme: Theme.of(context).primaryColor,
                      color_icon: Colors.white,
                      color_text: Colors.white,
                      color_text1: Colors.white54,
                      width: maxWidth / 2 - 15,
                    ),
                    facial_Decoration(
                      onTap: () =>
                          widget.gotoPage != null ? widget.gotoPage!(2) : null,
                      text1: "Hello",
                      text2: username,
                      icon: Icons.person,
                      color_shceme: Colors.white,
                      color_icon: Colors.black12,
                      color_text: Colors.black,
                      color_text1: Colors.black54,
                      width: maxWidth / 2 - 15,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "User List",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 30, left: 10, right: 10),
                  child: UserList(userList: userList),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
