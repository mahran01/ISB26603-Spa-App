import 'package:flutter/foundation.dart';
import 'package:spa_app/models/account.dart';
import 'package:spa_app/models/admin.dart';
import 'package:spa_app/models/facialbook.dart';
import 'package:spa_app/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._initialize();
  static Database? _database;
  DBHelper._initialize();

  Future _createDB(Database db, int version) async {
    const intPrimaryType = 'INTEGER PRIMARY KEY NOT NULL';
    const textType = 'TEXT NOT NULL';
    const textUniqueType = 'TEXT NOT NULL UNIQUE';
    const intType = 'INTEGER NOT NULL';
    const dateType = 'DATE NOT NULL';
    const timeType = 'TIME NOT NULL';

    await db.execute('''CREATE TABLE $userTable (
        ${UserFields.userid} $intPrimaryType,
        ${UserFields.name} $textType,
        ${UserFields.email} $textType,
        ${UserFields.phone} $intType,
        ${UserFields.username} $textUniqueType,
        ${UserFields.password} $textType
      )''');

    await db.execute('''CREATE TABLE $facialbookTable (
        ${FacialbookFields.bookid} $intPrimaryType,
        ${FacialbookFields.userid} $intType,
        ${FacialbookFields.appointmentDate} $dateType,
        ${FacialbookFields.appointmentTime} $timeType,
        ${FacialbookFields.services} $textType,
        FOREIGN KEY (${UserFields.userid}) REFERENCES $userTable (${UserFields.userid})
      )''');

    await db.execute('''CREATE TABLE $adminTable (
        ${AdminFields.adminid} $intPrimaryType,
        ${AdminFields.username} $textUniqueType,
        ${AdminFields.password} $textType
      )''');

    await db.insert(
      adminTable,
      Account(username: "admin", password: "123").toJson(),
    );
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<Database> _initDB(String filename) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, filename);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: _onConfigure,
    );
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDB('spa.db');
      return _database;
    }
  }

  Future<bool> userExist(String username, String password) async {
    final db = await instance.database;
    final maps = await db!.query(
      userTable,
      columns: UserFields.allFields,
      where: '${UserFields.username} = ? AND ${UserFields.password} = ?',
      whereArgs: [username, password],
    );
    return maps.isNotEmpty;
  }

  Future<bool> adminExists(String username, String password) async {
    final db = await instance.database;
    final maps = await db!.query(
      adminTable,
      columns: AdminFields.allFields,
      where: '${AdminFields.username} = ? AND ${AdminFields.password} = ?',
      whereArgs: [username, password],
    );
    return maps.isNotEmpty;
  }

  Future<bool> _userContainUsername(String username) async {
    final db = await instance.database;
    final maps = await db!.query(
      userTable,
      columns: UserFields.allFields,
      where: '${UserFields.username} = ?',
      whereArgs: [username],
    );
    return maps.isNotEmpty;
  }

  Future<bool> _adminContainUsername(String username) async {
    final db = await instance.database;
    final maps = await db!.query(
      adminTable,
      columns: AdminFields.allFields,
      where: '${AdminFields.username} = ?',
      whereArgs: [username],
    );
    return maps.isNotEmpty;
  }

  Future<bool> containsUsername(String username) async {
    return await _userContainUsername(username) ||
        await _adminContainUsername(username);
  }

  /// Method to create user
  /// Use:-
  /// Registration
  Future<Account> createUser(Account account) async {
    if (await containsUsername(account.username)) {
      throw Exception("Username already exist.");
    }
    final db = await instance.database;
    Map<String, Object?> accountToRegister = account.toJson();
    accountToRegister.remove(UserFields.userid);
    await db!.insert(userTable, accountToRegister);
    return account;
  }

  /// Method to get user based on their username.
  /// Use:-
  /// authentication (login)
  /// validation (registration)/(change username)
  /// search
  Future<User> getUser(String username) async {
    final db = await instance.database;
    final maps = await db!.query(
      userTable,
      columns: UserFields.allFields,
      where: '${UserFields.username} = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('User $username not found in the database.');
    }
  }

  /// Method to get user based on their username.
  /// Use:-
  /// authentication (login)
  /// validation (registration)/(change username)
  /// search
  Future<User> getUserById(int id) async {
    final db = await instance.database;
    final maps = await db!.query(
      userTable,
      columns: UserFields.allFields,
      where: '${UserFields.userid} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('User ID: $id not found in the database.');
    }
  }

  /// Method to get all user.
  /// Use:-
  /// Display on admin page
  Future<List<User>> getAllUsers() async {
    final db = await instance.database;
    final result = await db!.query(
      userTable,
      orderBy: '${UserFields.userid} ASC',
    );
    return result.map((e) => User.fromJson(e)).toList();
  }

  /// Method to update user base on userid.
  /// Use:-
  /// Edit user info
  Future<int> updateUser(User user) async {
    final db = await instance.database;
    User old = await getUserById(user.userid);
    if (old.username == user.username ||
        !await containsUsername(user.username)) {
      return db!.update(
        userTable,
        user.toJson(),
        where: '${UserFields.userid} = ?',
        whereArgs: [user.userid],
      );
    }
    return 0;
  }

  /// Method to delete user base on userid.
  /// Use:-
  /// Admin delete user
  /// User request acc deletion
  Future<int> deleteUser(int userid) async {
    final db = await instance.database;
    return db!.delete(
      userTable,
      where: '${UserFields.userid} = ?',
      whereArgs: [userid],
    );
  }

  /// Method to create facialbook.
  /// Use:-
  /// Create facialbook for user order.
  Future<Facialbook> createFacialbook(Facialbook facialbook) async {
    final db = await instance.database;
    await db!.insert(
      facialbookTable,
      facialbook.toJson(),
    );
    return facialbook;
  }

  /// Method to get facialbook.
  /// Use:-
  /// Display history for user and admin.
  Future<List<Facialbook>> getFacialbook(int userid) async {
    final db = await instance.database;
    final result = await db!.query(
      facialbookTable,
      orderBy:
          '${FacialbookFields.appointmentDate} DESC, ${FacialbookFields.appointmentTime} DESC',
      where: '${FacialbookFields.userid} = ?',
      whereArgs: [userid],
    );
    return result.map((e) => Facialbook.fromJson(e)).toList();
  }

  /// Mehtod to delete facial book.
  /// Use:-
  /// Delete invalid/concelled facialbook
  /// Might not need.
  Future<int> deleteFacialBook(int bookid) async {
    final db = await instance.database;
    return db!.delete(
      facialbookTable,
      where: '${FacialbookFields.bookid} = ?',
      whereArgs: [bookid],
    );
  }

  /// Method to create admin
  /// Use:-
  /// Registration of another admin
  Future<Account> createAdmin(Account account) async {
    if (!await containsUsername(account.username)) {
      throw Exception("Username already exist.");
    }
    final db = await instance.database;
    await db!.insert(userTable, account.toJson());
    return account;
  }

  /// Method to get admin based on their username.
  /// Use:-
  /// authentication (login)
  /// validation (registration)/(change username)
  /// search (admin search admin)
  Future<Admin> getAdmin(String username) async {
    final db = await instance.database;
    final maps = await db!.query(
      adminTable,
      columns: AdminFields.allFields,
      where: '${AdminFields.username} = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return Admin.fromJson(maps.first);
    } else {
      throw Exception('Admin $username not found in the database.');
    }
  }

  /// Method to get all admin.
  /// Use:-
  /// Display on admin page
  Future<List<Admin>> getAllAdmins() async {
    final db = await instance.database;
    final result = await db!.query(
      adminTable,
      orderBy: '${AdminFields.adminid} ASC',
    );
    return result.map((e) => Admin.fromJson(e)).toList();
  }

  /// Method to update admin base on adminid.
  /// Use:-
  /// Edit admin info
  Future<int> updateAdmin(Admin admin) async {
    final db = await instance.database;
    return db!.update(
      adminTable,
      admin.toJson(),
      where: '${AdminFields.adminid} = ?',
      whereArgs: [admin.adminid],
    );
  }

  /// Method to delete admin base on adminid.
  /// Use:-
  /// Admin delete admin
  /// User request acc deletion
  Future<int> deleteAdmin(int adminid) async {
    final db = await instance.database;
    return db!.delete(
      adminTable,
      where: '${AdminFields.adminid} = ?',
      whereArgs: [adminid],
    );
  }
}
