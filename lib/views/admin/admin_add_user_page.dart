import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:form_validator/form_validator.dart';

import 'package:spa_app/components/show_snackbar.dart';
import 'package:spa_app/components/spa_long_button.dart';
import 'package:spa_app/components/get_textformfield.dart';
import 'package:spa_app/functions/validator_extension.dart';
import 'package:spa_app/models/user.dart';
import 'package:spa_app/services/user_service.dart';

class AdminAddUserPage extends StatefulWidget {
  const AdminAddUserPage({super.key, this.onComplete});

  final void Function()? onComplete;

  @override
  State<AdminAddUserPage> createState() => _AdminAddUserPageState();
}

class _AdminAddUserPageState extends State<AdminAddUserPage> {
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

  createUser() async {
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
        await context.read<UserService>().registerAsAdmin(user).then((result) {
          if (result != "OK") {
            showSnackBar(context, result);
          } else {
            if (widget.onComplete != null) widget.onComplete!();
            Navigator.pop(context, "OK");
            showSnackBar(context, "Successfully created");
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new User'),
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
                    inputType: TextInputType.name,
                    hintName: 'Full Name',
                    validator: ValidationBuilder()
                        .name()
                        .minLength(1)
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
                        .minLength(1)
                        .maxLength(100)
                        .build(),
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conPhone,
                    icon: Icons.phone,
                    inputType: TextInputType.name,
                    hintName: 'Phone Number',
                    validator: ValidationBuilder().myPhone().build(),
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
                    validator: (value) {
                      if (value == "") {
                        return "The field is required";
                      }
                      if (value != _conPassword.text) {
                        return "Password does not match";
                      }
                      return null;
                    },
                    isObscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child:
                        SpaLongButton(onTap: createUser, text: "Create User"),
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
