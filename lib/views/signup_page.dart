import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/components/show_snackbar.dart';
import 'package:spa_app/components/spa_long_button.dart';
import 'package:spa_app/components/validation.dart';
import 'package:spa_app/components/get_textformfield.dart';
import 'package:spa_app/data_repository/db_helper.dart';
import 'package:spa_app/models/user.dart';
import 'package:spa_app/services/user_service.dart';
import 'package:spa_app/views/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPhone = TextEditingController();
  final _conUsername = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  signUp() async {
    DBHelper db = DBHelper.instance;

    String name = _conName.text;
    String email = _conEmail.text;
    String phone = _conPhone.text;
    String username = _conUsername.text;
    String password = _conPassword.text;
    String cpassword = _conCPassword.text;

    User user = User(
      userid: 0,
      name: name,
      email: email,
      phone: int.parse(phone),
      username: username,
      password: password,
    );

    if (context.mounted) {
      String result = await context.read<UserService>().register(user);
      if (result != "OK")
        showSnackBar(context, result);
      else
        showSnackBar(context, "Successfully register");
    }

    // if (_formKey.currentState!.validate()) {
    //   if (password != cpassword) {
    //     (context, 'Password Mismatch');
    //   } else {
    //     _formKey.currentState?.save();

    //     User user = User(userId, Name, email, phone, userName, password);
    //     await db.saveData(user).then((userData) {
    //       (context, "Successfully Saved");

    //       Navigator.push(
    //           context, MaterialPageRoute(builder: (_) => LoginPage()));
    //     }).catchError((error) {
    //       print(error);
    //       (context, "Error: Data Save Fail");
    //     });
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conName,
                    icon: Icons.person_outline,
                    inputType: TextInputType.name,
                    hintName: 'Full Name',
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conEmail,
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    hintName: 'Email',
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conPhone,
                    icon: Icons.phone,
                    inputType: TextInputType.name,
                    hintName: 'Phone Number',
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conUsername,
                    icon: Icons.person_3,
                    inputType: TextInputType.name,
                    hintName: 'Username',
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conCPassword,
                    icon: Icons.lock,
                    hintName: 'Confirm Password',
                    isObscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: SpaLongButton(onTap: signUp, text: "Sign Up"),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? '),
                        TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Theme.of(context).primaryColor),
                          child: Text('Login'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
