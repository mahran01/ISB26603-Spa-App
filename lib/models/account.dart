class AccountFields {
  static const String username = 'username';
  static const String password = 'password';

  static const List<String> allFields = [
    username,
    password,
  ];
}

class Account {
  String username;
  String password;

  Account({
    required this.username,
    required this.password,
  });

  Map<String, Object?> toJson() => {
        AccountFields.username: username,
        AccountFields.password: password,
      };
}
