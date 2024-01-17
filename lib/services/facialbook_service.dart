import 'package:flutter/material.dart';
import 'package:spa_app/data_repository/db_helper.dart';
import 'package:spa_app/functions/shared.dart';
import 'package:spa_app/models/facialbook.dart';

class FacialBookService with ChangeNotifier {
  List<Facialbook>? _facialbookList;

  List<Facialbook>? get getFacialBookList => _facialbookList;

  void _updateFacialBookList() {
    _facialbookList!.sort((a, b) {
      DateTime aDate = combineDateTime(a.appointmentDate, a.appointmentTime);
      DateTime bDate = combineDateTime(b.appointmentDate, b.appointmentTime);
      int n = aDate.compareTo(bDate);
      if (n != 0) {
        return n;
      }
      return a.bookid.compareTo(b.bookid);
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

  unbind() {
    _facialbookList = null;
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
