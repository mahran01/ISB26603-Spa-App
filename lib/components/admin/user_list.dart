import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/components/show_snackbar.dart';
import 'package:spa_app/models/user.dart';
import 'package:spa_app/services/user_service.dart';
import 'package:spa_app/views/admin/admin_update_user_page.dart';

class UserList extends StatefulWidget {
  const UserList({super.key, required this.userList});

  final List<User> userList;

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late List<User> userList;
  late List<bool> userSelected;
  late int userCount;

  @override
  void initState() {
    super.initState();
    userList = widget.userList;
    userCount = userList.length;
    userSelected = userList.map((e) => false).toList();
  }

  void userOnTap(int index) {
    setState(() {
      if (userSelected[index]) {
        userSelected[index] = false;
      } else {
        userSelected = userList.map((e) => false).toList();
        userSelected[index] = true;
      }
    });
  }

  void userDelete(BuildContext context, int index) {
    User user = userList[index];
    ThemeData theme = Theme.of(context);
    TextTheme txtTheme = theme.textTheme;

    final formKey = GlobalKey<FormState>();
    final TextEditingController conPassword = TextEditingController();

    Widget getText(text) {
      return Text(
        text,
        style: txtTheme.bodyLarge,
      );
    }

    Widget makeTable(Map<String, String> data) {
      double padding = 5.0;
      return Table(
        columnWidths: const {
          0: IntrinsicColumnWidth(),
          1: IntrinsicColumnWidth(),
          2: FlexColumnWidth(),
        },
        border: TableBorder(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
          ),
          horizontalInside: BorderSide(
            color: Colors.white.withOpacity(0.1),
          ),
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: data.entries
            .map(
              (e) => TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: padding),
                    child: Text(e.key),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding),
                    child: const Text("  :  "),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: padding),
                    child: Text(e.value),
                  ),
                ],
              ),
            )
            .toList(),
      );
    }

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Form(
          key: formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText("Confirm delete user?"),
                const SizedBox(height: 10.0),
                makeTable({
                  "User Id": user.userid.toString(),
                  "Username": user.username,
                  "Name": user.name,
                }),
                const SizedBox(height: 10.0),
                getText("Enter your password: "),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Password"),
                  controller: conPassword,
                  obscureText: true,
                  validator: (value) {
                    String password =
                        context.read<UserService>().getCurrentAdmin!.password;
                    if (value == "" || value == null) {
                      return "Please enter your password to confirm.";
                    } else if (password != value) {
                      return "Invalid password, please try again.";
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                await context
                    .read<UserService>()
                    .deleteUser(user.userid)
                    .then((result) {
                  if (result != "OK") {
                    showSnackBar(context, result);
                  } else {
                    setState(() {
                      userList = context.read<UserService>().getAlUser!;
                      userSelected = userList.map((e) => false).toList();
                      userCount = userList.length;
                      Navigator.pop(context, 'OK');
                    });
                  }
                });
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void userEdit(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => AdminUpdateUserPage(
          user: userList[index],
        ),
      ),
    ).then((result) {
      if (result == "OK") {
        setState(() {});
      }
    });
  }

  Widget getExpandedSection(int index) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            // color: Colors.black,
            thickness: 1,
            height: 20,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => userDelete(context, index),
              child: Container(
                width: 150,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF004F),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Remove",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => userEdit(context, index),
              child: Container(
                width: 150,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF7165D6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildSingleCard(context, index) {
    User user = userList[index];
    bool isExpanded = userSelected[index];
    return GestureDetector(
      onTap: () => userOnTap(index),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  user.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "#${user.username}",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("images/profleimage.png"),
                ),
              ),
              isExpanded ? getExpandedSection(index) : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    userList = context.read<UserService>().getAlUser!;
    if (userCount != userList.length) {
      userSelected = userList.map((e) => false).toList();
      userCount = userList.length;
    }
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: userCount,
      itemBuilder: (context, index) {
        return buildSingleCard(context, index);
      },
    );
  }
}
