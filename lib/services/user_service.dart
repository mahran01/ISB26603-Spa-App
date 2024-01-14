import 'package:flutter/material.dart';
import 'package:spa_app/data_repository/db_helper.dart';
import 'package:spa_app/models/admin.dart';
import 'package:spa_app/models/account.dart';
import 'package:spa_app/models/facialbook.dart';
import 'package:spa_app/models/user.dart';

enum AccountType { user, admin }

class UserService with ChangeNotifier {
  late User? _currentUser;
  late Admin? _currentAdmin;
  late AccountType? _currentAccountType;
  late List<User>? _allUser;
  bool _userExists = false;

  User? get getCurrentUser => _currentUser;
  Admin? get getCurrentAdmin => _currentAdmin;
  AccountType? get getCurrentAccountType => _currentAccountType;
  List<User>? get getAlUser => _allUser;
  bool get getUserExists => _userExists;

  set setUserExists(bool value) {
    _userExists = value;
    notifyListeners();
  }

  Future<String> _bindAllUser() async {
    DBHelper db = DBHelper.instance;
    String result = "OK";
    try {
      _allUser = await db.getAllUsers();
      notifyListeners();
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    return result;
  }

  Future<String> login(String username, String password) async {
    DBHelper db = DBHelper.instance;
    String result = "OK";
    try {
      if (!await db.containsUsername(username)) {
        throw Exception("Username does not exist.");
      } else if (await db.userExist(username, password)) {
        _currentUser = await db.getUser(username);
        _currentAdmin = null;

        _currentAccountType = AccountType.user;
      } else if (await db.adminExists(username, password)) {
        _currentAdmin = await db.getAdmin(username);
        await _bindAllUser();
        _currentUser = null;
        _currentAccountType = AccountType.admin;
      } else {
        throw Exception("Invalid password.");
      }
      notifyListeners();
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    return result;
  }

  logout() {
    _currentUser = null;
    _currentAdmin = null;
    _currentAccountType = null;
  }

  Future<String> register(Account account) async {
    String result = "OK";
    try {
      await DBHelper.instance.createUser(account);
      notifyListeners();
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    return result;
  }

  Future<String> registerAsAdmin(Account account) async {
    String result = "OK";
    try {
      await DBHelper.instance.createUser(account);
      _allUser!.add(account as User);
      notifyListeners();
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    return result;
  }

  Future<String> update(Account account) async {
    DBHelper db = DBHelper.instance;
    String result = "OK";

    try {
      if (account is User) {
        await db.updateUser(account).then((e) {
          if (_currentAccountType == AccountType.user) {
            _currentUser = account;
            _currentAdmin = null;
          } else if (_currentAccountType == AccountType.admin) {
            User userAddress =
                _allUser!.firstWhere((e) => e.userid == account.userid);
            userAddress.name = account.name;
            userAddress.email = account.email;
            userAddress.phone = account.phone;
            userAddress.username = account.username;
            userAddress.password = account.password;
          }
        });
      } else if (account is Admin) {
        await db.updateAdmin(account);
        if (_currentAccountType == AccountType.admin) {
          _currentAdmin = account;
        }
      } else {
        throw Exception("Account type error.");
      }
      notifyListeners();
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    return result;
  }

  Future<String> deleteUser(int userid) async {
    DBHelper db = DBHelper.instance;
    String result = "OK";

    try {
      if (_currentAccountType == AccountType.admin) {
        await db.deleteUserAndBook(userid).then((value) {
          _allUser!.removeWhere((e) => e.userid == userid);
        });
      } else {
        throw Exception("Invalid operation for this account type.");
      }
      notifyListeners();
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    return result;
  }
}

String getHumanReadableError(String message) {
  if (message.contains('UNIQUE constraint failed')) {
    return 'Username is not available.';
  }
  if (message.contains('not found in the database')) {
    return 'Username is not registered.';
  }
  if (message.contains('already exist')) {
    return 'Username already registered.';
  }
  return message;
}
