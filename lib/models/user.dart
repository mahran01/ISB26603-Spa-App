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

class User {
  int userid;
  String name;
  String email;
  int phone;
  String username;
  String password;

  User({
    required this.userid,
    required this.name,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
  });

  Map<String, Object?> toJson() => {
        UserFields.userid: userid,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.phone: phone,
        UserFields.username: username,
        UserFields.password: password,
      };

  static User fromJson(Map<String, Object?> json) => User(
        userid: int.parse(json[UserFields.userid] as String),
        name: json[UserFields.name] as String,
        email: json[UserFields.email] as String,
        phone: int.parse(json[UserFields.phone] as String),
        username: json[UserFields.username] as String,
        password: json[UserFields.password] as String,
      );
}
