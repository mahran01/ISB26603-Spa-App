import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/components/get_textformfield.dart';
import 'package:spa_app/components/show_snackbar.dart';
import 'package:spa_app/components/spa_long_button.dart';
import 'package:spa_app/functions/validator_extension.dart';
import 'package:spa_app/models/user.dart';
import 'package:spa_app/services/user_service.dart';

class AdminUpdateUserPage extends StatefulWidget {
  const AdminUpdateUserPage({super.key, required this.user});

  final User user;

  @override
  State<AdminUpdateUserPage> createState() => _AdminUpdateUserPageState();
}

class _AdminUpdateUserPageState extends State<AdminUpdateUserPage> {
  final _formKey = GlobalKey<FormState>();

  late User user = widget.user;
  final TextEditingController _conName = TextEditingController();
  final TextEditingController _conEmail = TextEditingController();
  final TextEditingController _conPhone = TextEditingController();
  final TextEditingController _conUsername = TextEditingController();
  final TextEditingController _conPassword = TextEditingController();

  update() async {
    if (_formKey.currentState!.validate()) {
      String name = _conName.text;
      String email = _conEmail.text;
      String phone = _conPhone.text;
      String username = _conUsername.text;
      String password = _conPassword.text;

      User newUser = User(
        userid: user.userid,
        name: name,
        email: email,
        phone: int.parse(phone),
        username: username,
        password: password,
      );
      await context.read<UserService>().update(newUser).then((result) {
        if (result != "OK") {
          showSnackBar(context, result);
        } else {
          setState(() {
            Navigator.pop(context, "OK");
            showSnackBar(context, "Successfully updated");
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String name, email, phone, username, password;
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
      ),
    );
  }
}
