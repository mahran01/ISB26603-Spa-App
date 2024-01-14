import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spa_app/models/facialbook.dart';
import 'package:spa_app/models/user.dart';

String decodeList(String json) {
  String listString = jsonDecode(json).toString();
  listString = listString.substring(1, listString.length - 1);
  return "Services: $listString";
}

String getUserameFromBook(List<User> userList, Facialbook fb) =>
    userList.firstWhere((e) => e.userid == fb.userid).username;

DateTime combineDateTime(DateTime dt, TimeOfDay tod) =>
    DateTime(dt.year, dt.month, dt.day, tod.hour, tod.minute);

List<Facialbook> getDueNowScedule(List<Facialbook> fbList) {
  List<Facialbook> returnList = fbList
      .where((e) =>
          combineDateTime(e.appointmentDate, e.appointmentTime)
              .isBefore(DateTime.now()) &&
          combineDateTime(e.appointmentDate, e.appointmentTime)
              .isAfter(DateTime.now().subtract(const Duration(hours: 1))))
      .toList();
  returnList.sort((a, b) => a.bookid.compareTo(b.bookid));
  return returnList;
}

List<Facialbook> getDueSchedule(List<Facialbook> fbList) {
  List<Facialbook> returnList = fbList
      .where((e) => combineDateTime(e.appointmentDate, e.appointmentTime)
          .isAfter(DateTime.now()))
      .toList();
  returnList.sort((a, b) {
    int n = combineDateTime(a.appointmentDate, a.appointmentTime)
        .compareTo(combineDateTime(b.appointmentDate, b.appointmentTime));
    if (n != 0) {
      return n;
    }
    return a.bookid.compareTo(b.bookid);
  });
  return returnList;
}

List<Facialbook> getOverdueScehdule(List<Facialbook> fbList) {
  List<Facialbook> returnList = fbList
      .where((e) =>
          combineDateTime(e.appointmentDate, e.appointmentTime)
              .isBefore(DateTime.now()) ||
          combineDateTime(e.appointmentDate, e.appointmentTime)
              .isAtSameMomentAs(DateTime.now()))
      .toList();
  returnList.sort((a, b) {
    int n = combineDateTime(a.appointmentDate, a.appointmentTime)
        .compareTo(combineDateTime(b.appointmentDate, b.appointmentTime));
    if (n != 0) {
      return n;
    }
    return a.bookid.compareTo(b.bookid);
  });
  return returnList;
}
