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

class Admin {
  int adminid;
  String username;
  String password;

  Admin({
    required this.adminid,
    required this.username,
    required this.password,
  });

  Map<String, Object?> toJson() => {
        AdminFields.adminid: adminid,
        AdminFields.username: username,
        AdminFields.password: password,
      };

  static Admin fromJson(Map<String, Object?> json) => Admin(
        adminid: int.parse(json[AdminFields.adminid] as String),
        username: json[AdminFields.username] as String,
        password: json[AdminFields.password] as String,
      );
}
