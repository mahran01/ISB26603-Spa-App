import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/components/schedule_card.dart';
import 'package:spa_app/components/show_snackbar.dart';
import 'package:spa_app/data_repository/db_helper.dart';
import 'package:spa_app/models/facialbook.dart';
import 'package:spa_app/models/user.dart';
import 'package:spa_app/services/facialbook_service.dart';
import 'package:spa_app/services/user_service.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  update() async {}

  late List<Facialbook> fb;

  delete(BuildContext context, int index) async {
    await context
        .read<FacialBookService>()
        .deleteFacialBook(fb[index].bookid)
        .then((result) {
      if (result != "OK") {
        showSnackBar(context, result);
      } else {
        setState(() {
          showSnackBar(context, "Successfully delete");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    late User user = context.read<UserService>().getCurrentUser!;
    fb = context.read<FacialBookService>().getFacialBookList ?? [];

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
                bookid: fb[index].bookid.toString(),
                services: decode(fb[index].services),
                date: DateFormat.yMMMd().format(fb[index].appointmentDate),
                time: timeToString(fb[index].appointmentTime),
                update: () {},
                delete: () => delete(context, index),
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
