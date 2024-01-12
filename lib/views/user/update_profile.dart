import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/components/get_textformfield.dart';
import 'package:spa_app/components/show_snackbar.dart';
import 'package:spa_app/components/spa_long_button.dart';
import 'package:spa_app/models/user.dart';
import 'package:spa_app/services/user_service.dart';
import 'package:spa_app/views/user/bottom_navigation.dart';
import 'package:spa_app/views/user/setting.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = new GlobalKey<FormState>();

  late User user = context.read<UserService>().getCurrentUser!;
  final TextEditingController _conName = TextEditingController();
  final TextEditingController _conEmail = TextEditingController();
  final TextEditingController _conPhone = TextEditingController();
  final TextEditingController _conUsername = TextEditingController();
  final TextEditingController _conPassword = TextEditingController();

  update() async {
    User newUser = User(
      userid: user.userid,
      name: _conName.text,
      email: _conEmail.text,
      phone: int.parse(_conPhone.text),
      username: _conUsername.text,
      password: _conPassword.text,
    );
    await context.read<UserService>().update(newUser).then((result) {
      if (result != "OK")
        showSnackBar(context, result);
      else
        showSnackBar(context, "Successfully updated");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavigation(initialIndex: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    String userid, name, email, phone, username, password;
    userid = user.userid.toString();
    name = user.name;
    email = user.email;
    phone = user.phone.toString();
    username = user.username;
    password = user.password;

    _conName.text = name;
    _conEmail.text = email;
    _conPhone.text = phone;
    _conUsername.text = username;
    _conPassword.text = password;

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Container(
                  height: 190,
                  width: 190,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/profleimage.png"),
                        fit: BoxFit.contain),
                  ),
                ),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conName,
                  icon: Icons.person_outline,
                  hintName: 'Full Name',
                ),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conEmail,
                  icon: Icons.email,
                  hintName: 'Email',
                ),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conPhone,
                  icon: Icons.phone,
                  hintName: 'Phone Number',
                ),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conUsername,
                  icon: Icons.person_3,
                  hintName: 'Username',
                ),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conPassword,
                  icon: Icons.lock,
                  hintName: 'Password',
                  isObscureText: true,
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: SpaLongButton(onTap: update, text: "Update Profile"),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
