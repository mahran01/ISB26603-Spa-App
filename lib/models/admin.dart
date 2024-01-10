import 'package:spa_app/models/account.dart';

const String adminTable = 'admin';

class AdminFields {
  static const String adminid = 'adminid';
  static const String username = 'username';
  static const String password = 'password';

  static const List<String> allFields = [
    adminid,
    username,
    password,
  ];
}

class Admin extends Account {
  int adminid;

  Admin({
    required this.adminid,
    required super.username,
    required super.password,
  });

  @override
  Map<String, Object?> toJson() => {
        AdminFields.adminid: adminid,
        ...super.toJson(),
      };

  static Admin fromJson(Map<String, Object?> json) => Admin(
        adminid: json[AdminFields.adminid] as int,
        username: json[AdminFields.username] as String,
        password: json[AdminFields.password] as String,
      );
}
