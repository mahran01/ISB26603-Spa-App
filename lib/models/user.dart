import 'package:spa_app/models/account.dart';

const String userTable = 'user';

class UserFields {
  static const String userid = 'userid';
  static const String name = 'name';
  static const String email = 'email';
  static const String phone = 'phone';
  static const String username = 'username';
  static const String password = 'password';

  static const List<String> allFields = [
    userid,
    name,
    email,
    phone,
    username,
    password,
  ];
}

class User extends Account {
  int userid;
  String name;
  String email;
  int phone;

  User({
    required this.userid,
    required this.name,
    required this.email,
    required this.phone,
    required super.username,
    required super.password,
  });

  @override
  Map<String, Object?> toJson() => {
        UserFields.userid: userid,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.phone: phone,
        ...super.toJson(),
      };

  static User fromJson(Map<String, Object?> json) => User(
        userid: json[UserFields.userid] as int,
        name: json[UserFields.name] as String,
        email: json[UserFields.email] as String,
        phone: json[UserFields.phone] as int,
        username: json[UserFields.username] as String,
        password: json[UserFields.password] as String,
      );
}
