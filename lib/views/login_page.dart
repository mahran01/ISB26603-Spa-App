import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/components/get_textformfield.dart';
import 'package:spa_app/components/show_snackbar.dart';
import 'package:spa_app/components/spa_long_button.dart';
import 'package:spa_app/config/routes/route_manager.dart';
import 'package:spa_app/models/facialbook.dart';
import 'package:spa_app/models/user.dart';
import 'package:spa_app/services/facialbook_service.dart';
import 'package:spa_app/services/user_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _conUsername = TextEditingController();
  final _conPassword = TextEditingController();

  login() async {
    String username = _conUsername.text;
    String password = _conPassword.text;
    FocusManager.instance.primaryFocus?.unfocus();
    if (username.isEmpty) {
      showSnackBar(context, 'Please enter your username.');
    } else if (password.isEmpty) {
      showSnackBar(context, 'Please enter your password.');
    } else {
      await context
          .read<UserService>()
          .login(_conUsername.text.trim(), _conPassword.text)
          .then((result) async {
        if (result != 'OK') {
          showSnackBar(context, result);
          return;
        } else {
          AccountType accountType =
              context.read<UserService>().getCurrentAccountType;
          switch (accountType) {
            case AccountType.user:
              User user = context.read<UserService>().getCurrentUser!;
              await context
                  .read<FacialBookService>()
                  .bindUserFacialbook(user.userid)
                  .then((value) {
                if (value != 'OK') {
                  showSnackBar(context, value);
                  return;
                } else {
                  RouteManager.userHome(context);
                }
              });
              break;
            case AccountType.admin:
              RouteManager.adminHome(context);
              break;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Signup'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset("images/WelcomePage.jpg"),
                ),
                getTextFormField(
                  controller: _conUsername,
                  icon: Icons.person,
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
                  child: SpaLongButton(onTap: login, text: "Log In"),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Doesn\'t have an account? '),
                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).primaryColor),
                        child: Text('Sign Up'),
                        onPressed: () => RouteManager.signup(context),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
