import 'package:flutter/material.dart';
import 'package:spa_app/components/validation.dart';
import 'package:spa_app/components/get_textformfield.dart';
import 'package:spa_app/data_repository/spa_database.dart';
import 'package:spa_app/models/user.dart';
import 'package:spa_app/views/login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPhone = TextEditingController();
  final _conUserName = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  var db;

  @override
  void initState() {
    super.initState();
    db = SpaDatabase;
  }

  signUp() async {
    String userId = _conUserId.text;
    String Name = _conName.text;
    String email = _conEmail.text;
    String phone = _conPhone.text;
    String userName = _conUserName.text;
    String password = _conPassword.text;
    String cpassword = _conCPassword.text;

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
        backgroundColor: Color(0xFF7165D6),
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
                    controller: _conUserId,
                    icon: Icons.person,
                    hintName: 'User ID',
                  ),
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
                    controller: _conUserName,
                    icon: Icons.person_3,
                    inputType: TextInputType.name,
                    hintName: 'User Name',
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
                  Container(
                    margin: EdgeInsets.all(20.0),
                    width: double.infinity,
                    child: TextButton(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: signUp,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF7165D6),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? '),
                        TextButton(
                          style:
                              TextButton.styleFrom(primary: Color(0xFF7165D6)),
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
