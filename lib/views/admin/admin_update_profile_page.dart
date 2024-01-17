import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/components/get_textformfield.dart';
import 'package:spa_app/components/show_snackbar.dart';
import 'package:spa_app/components/spa_long_button.dart';
import 'package:spa_app/functions/validator_extension.dart';
import 'package:spa_app/models/admin.dart';
import 'package:spa_app/services/user_service.dart';

class AdminUpdateProfilePage extends StatefulWidget {
  const AdminUpdateProfilePage({super.key});

  @override
  State<AdminUpdateProfilePage> createState() => _AdminUpdateProfilePageState();
}

class _AdminUpdateProfilePageState extends State<AdminUpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late Admin admin = context.read<UserService>().getCurrentAdmin!;
  final TextEditingController _conUsername = TextEditingController();
  final TextEditingController _conPassword = TextEditingController();

  update() async {
    if (_formKey.currentState!.validate()) {
      String username = _conUsername.text;
      String password = _conPassword.text;

      Admin newAdmin = Admin(
        adminid: admin.adminid,
        username: username,
        password: password,
      );
      await context.read<UserService>().update(newAdmin).then((result) {
        if (result != "OK") {
          showSnackBar(context, result);
        } else {
          showSnackBar(context, "Successfully updated");
          Navigator.pop(context, "OK");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String username, password;
    username = admin.username;
    password = admin.password;

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
