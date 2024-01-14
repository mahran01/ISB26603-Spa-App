import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/components/schedule_card.dart';
import 'package:spa_app/functions/shared.dart';
import 'package:spa_app/models/facialbook.dart';
import 'package:spa_app/models/user.dart';
import 'package:spa_app/services/facialbook_service.dart';
import 'package:spa_app/services/user_service.dart';

class AdminSchedulePage extends StatefulWidget {
  const AdminSchedulePage({super.key});
  @override
  State<AdminSchedulePage> createState() => _AdminSchedulePageState();
}

class _AdminSchedulePageState extends State<AdminSchedulePage> {
  late List<Facialbook> fbList;
  late List<User> userList;

  update() {}

  delete() {}

  @override
  Widget build(BuildContext context) {
    fbList = context.read<FacialBookService>().getFacialBookList ?? [];
    userList = context.read<UserService>().getAlUser ?? [];

    List<Facialbook> dueNowFb = getDueNowScedule(fbList);
    List<Facialbook> dueFb = getDueSchedule(fbList);
    List<Facialbook> overdueFb = getOverdueScehdule(fbList);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 30, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createText("Current Schedule"),
              dueNowFb.isEmpty ? createNoSchedule() : createList(dueNowFb),
              const SizedBox(height: 20.0),
              createText("Upcoming schedule"),
              dueFb.isEmpty ? createNoSchedule() : createList(dueFb),
              const SizedBox(height: 20.0),
              createText("Past schedule"),
              overdueFb.isEmpty ? createNoSchedule() : createList(overdueFb),
            ],
          ),
        ),
      ),
    );
  }

  Widget createNoSchedule() {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        "No scheduled appointment",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: Colors.black38,
        ),
      ),
    );
  }

  Widget createText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const Expanded(child: Divider()),
      ]),
    );
  }

  Widget createList(List<Facialbook> fbList) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: fbList.length,
      itemBuilder: (BuildContext context, int index) {
        return ScheduleCard(
          title: "User #${getUserameFromBook(userList, fbList[index])}",
          services: decodeList(fbList[index].services),
          date: DateFormat.yMMMd().format(fbList[index].appointmentDate),
          time: timeToString(fbList[index].appointmentTime),
        );
      },
    );
  }

  String timeToString(TimeOfDay tod) {
    return "${tod.hourOfPeriod.toString().padLeft(2, "0")}:${tod.minute.toString().padLeft(2, "0")} ${tod.hour < 12 ? "am" : "pm"}";
  }
}
