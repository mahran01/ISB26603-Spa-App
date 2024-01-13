import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/components/schedule_card.dart';
import 'package:spa_app/data_repository/db_helper.dart';
import 'package:spa_app/models/facialbook.dart';
import 'package:spa_app/models/user.dart';
import 'package:spa_app/services/facialbook_service.dart';
import 'package:spa_app/services/user_service.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  update() {}

  delete() {}

  @override
  Widget build(BuildContext context) {
    List<Facialbook> fb =
        context.read<FacialBookService>().getFacialBookList ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: fb.length,
            itemBuilder: (BuildContext context, int index) {
              return ScheduleCard(
                services: decode(fb[index].services),
                date: DateFormat.yMMMd().format(fb[index].appointmentDate),
                time: timeToString(fb[index].appointmentTime),
                update: () {},
                delete: () {},
              );
            },
          ),
        ),
      ),
    );
  }

  String decode(String json) {
    String listString = jsonDecode("[$json]").toString();
    return listString.substring(1, listString.length - 1);
  }

  String timeToString(TimeOfDay tod) {
    return "${tod.hourOfPeriod.toString().padLeft(2, "0")}:${tod.minute.toString().padLeft(2, "0")} ${tod.hour < 12 ? "am" : "pm"}";
  }
}
