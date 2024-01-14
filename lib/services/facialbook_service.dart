import 'package:flutter/material.dart';
import 'package:spa_app/data_repository/db_helper.dart';
import 'package:spa_app/models/facialbook.dart';
import 'package:spa_app/models/user.dart';

class FacialBookService with ChangeNotifier {
  List<Facialbook>? _facialbookList;

  List<Facialbook>? get getFacialBookList => _facialbookList;

  void _updateFacialBookList() {
    _facialbookList!.sort((a, b) {
      DateTime aDate = a.appointmentDate;
      DateTime bDate = b.appointmentDate;
      bool n = bDate.isBefore(aDate);
      if (!aDate.isAtSameMomentAs(bDate)) {
        return n ? -1 : 1;
      }
      TimeOfDay aTime = a.appointmentTime;
      TimeOfDay bTime = b.appointmentTime;
      return bTime.hour - aTime.hour;
    });
  }

  Future<String> makeAppointment(Facialbook fb) async {
    DBHelper db = DBHelper.instance;
    String result = "OK";
    try {
      if (_facialbookList != null) {
        await db.createFacialbook(fb).then((v) {
          _facialbookList!.add(fb);
        });
        notifyListeners();
      } else {
        throw Exception("Facialbook List is not bind.");
      }
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    return result;
  }

  Future<String> bindUserFacialbook(int userid) async {
    DBHelper db = DBHelper.instance;
    String result = "OK";
    try {
      _facialbookList = await db.getFacialbook(userid);
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    return result;
  }

  Future<String> bindAllFacialbook() async {
    DBHelper db = DBHelper.instance;
    String result = "OK";
    try {
      _facialbookList = await db.getAllFacialbook();
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    return result;
  }

  Future<String> updateFacialBook(Facialbook fb) async {
    DBHelper db = DBHelper.instance;
    String result = "OK";
    try {
      await db.updateFacialBook(fb).then((v) {
        _facialbookList!.removeWhere((e) => e.bookid == fb.bookid);
      });
      notifyListeners();
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    return result;
  }

  Future<String> deleteFacialBook(int bookid) async {
    DBHelper db = DBHelper.instance;
    String result = "OK";
    try {
      await db.deleteFacialBook(bookid).then((v) {
        _facialbookList!.removeWhere((e) => e.bookid == bookid);
      });
      notifyListeners();
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    return result;
  }
  // Future<String> login(String username, String password) async {
  //   DBHelper db = DBHelper.instance;
  //   String result = "OK";
  //   try {
  //     if (!await db.containsUsername(username)) {
  //       throw Exception("Username does not exist.");
  //     } else if (await db.userExist(username, password)) {
  //       _currentUser = await db.getUser(username);
  //       _currentAdmin = null;
  //       _currentAccountType = AccountType.user;
  //     } else if (await db.adminExists(username, password)) {
  //       _currentAdmin = await db.getAdmin(username);
  //       _currentUser = null;
  //       _currentAccountType = AccountType.admin;
  //     } else {
  //       throw Exception("Invalid password.");
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     result = getHumanReadableError(e.toString());
  //   }
  //   return result;
  // }

  // Future<String> register(Account account) async {
  //   String result = "OK";
  //   try {
  //     await DBHelper.instance.createUser(account);
  //     notifyListeners();
  //   } catch (e) {
  //     result = getHumanReadableError(e.toString());
  //   }
  //   return result;
  // }

  // Future<String> update(Account account) async {
  //   DBHelper db = DBHelper.instance;
  //   String result = "OK";
  //   try {
  //     switch (_currentAccountType) {
  //       case AccountType.user:
  //         await db.updateUser(account as User);
  //         _currentUser = account;
  //         _currentAdmin = null;
  //         break;
  //       case AccountType.admin:
  //         await db.updateAdmin(account as Admin);
  //         _currentAdmin = account;
  //         _currentUser = null;
  //         break;
  //       default:
  //         throw Exception("Account type error.");
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     result = getHumanReadableError(e.toString());
  //   }
  //   return result;
  // }
}

String getHumanReadableError(String message) {
  if (message.contains('UNIQUE constraint failed')) {
    return 'Username is not available.';
  }
  if (message.contains('not found in the database')) {
    return 'Username is not registered.';
  }
  return message;
}
