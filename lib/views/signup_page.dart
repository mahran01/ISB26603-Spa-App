import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:form_validator/form_validator.dart';

import 'package:spa_app/components/show_snackbar.dart';
import 'package:spa_app/components/spa_long_button.dart';
import 'package:spa_app/components/get_textformfield.dart';
import 'package:spa_app/config/routes/route_manager.dart';
import 'package:spa_app/extensions/validator_extension.dart';
import 'package:spa_app/models/user.dart';
import 'package:spa_app/services/user_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

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
    if (_formKey.currentState!.validate()) {
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
      if (password != cpassword) {
        (context, 'Password Mismatch');
      } else {
        _formKey.currentState?.save();
        await context.read<UserService>().register(user).then((result) {
          if (result != "OK") {
            showSnackBar(context, result);
          } else {
            showSnackBar(context, "Successfully register");
            RouteManager.login(context);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        RouteManager.welcome(context);
        return true;
      },
      child: Scaffold(
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
                      validator: ValidationBuilder()
                          .name()
                          .minLength(5)
                          .maxLength(100)
                          .build(),
                    ),
                    SizedBox(height: 10.0),
                    getTextFormField(
                      controller: _conEmail,
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Email',
                      validator: ValidationBuilder()
                          .email()
                          .minLength(5)
                          .maxLength(100)
                          .build(),
                    ),
                    SizedBox(height: 10.0),
                    getTextFormField(
                      controller: _conPhone,
                      icon: Icons.phone,
                      inputType: TextInputType.name,
                      hintName: 'Phone Number',
                      validator: ValidationBuilder()
                          .numeric()
                          .minLength(8)
                          .maxLength(14)
                          .build(),
                    ),
                    SizedBox(height: 10.0),
                    getTextFormField(
                      controller: _conUsername,
                      icon: Icons.person_3,
                      inputType: TextInputType.name,
                      hintName: 'Username',
                      validator: ValidationBuilder().username().build(),
                    ),
                    SizedBox(height: 10.0),
                    getTextFormField(
                      controller: _conPassword,
                      icon: Icons.lock,
                      hintName: 'Password',
                      isObscureText: true,
                      validator: ValidationBuilder().password().build(),
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
                                foregroundColor:
                                    Theme.of(context).primaryColor),
                            child: Text('Login'),
                            onPressed: () => RouteManager.login(context),
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
      ),
    );
  }
}
