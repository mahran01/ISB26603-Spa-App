import 'package:flutter/material.dart';

const String facialbookTable = 'facialbook';

class FacialbookFields {
  static const String bookid = 'bookid';
  static const String userid = 'userid';
  static const String appointmentDate = 'appointmentDate';
  static const String appointmentTime = 'appointmentTime';
  static const String services = 'services';

  static const List<String> allFields = [
    bookid,
    userid,
    appointmentDate,
    appointmentTime,
    services,
  ];
}

class Facialbook {
  final int bookid;
  final int userid;
  final DateTime appointmentDate;
  final TimeOfDay appointmentTime;
  final String services;

  Facialbook({
    required this.bookid,
    required this.userid,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.services,
  });

  DateTime getDateTime() {
    return DateTime(
      appointmentDate.year,
      appointmentDate.month,
      appointmentDate.day,
      appointmentTime.hour,
      appointmentTime.minute,
    );
  }

  static _toStringTime(TimeOfDay tod) =>
      "${tod.hour.toString().padLeft(2, '0')}:${tod.minute.toString().padLeft(2, '0')}";

  Map<String, Object?> toJson() => {
        FacialbookFields.bookid: bookid,
        FacialbookFields.userid: userid,
        FacialbookFields.appointmentDate: appointmentDate.toIso8601String(),
        FacialbookFields.appointmentTime: _toStringTime(appointmentTime),
        FacialbookFields.services: services,
      };

  static TimeOfDay _stringToTimeOfDay(String s) => TimeOfDay(
        hour: int.parse(s.split(":")[0]),
        minute: int.parse(s.split(":")[1]),
      );

  static Facialbook fromJson(Map<String, Object?> json) => Facialbook(
        bookid: json[FacialbookFields.bookid] as int,
        userid: json[FacialbookFields.userid] as int,
        appointmentDate:
            DateTime.parse(json[FacialbookFields.appointmentDate] as String),
        appointmentTime:
            _stringToTimeOfDay([FacialbookFields.appointmentTime] as String),
        services: json[FacialbookFields.services] as String,
      );
}
