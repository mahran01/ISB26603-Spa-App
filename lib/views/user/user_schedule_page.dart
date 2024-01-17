import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/components/schedule_card.dart';
import 'package:spa_app/components/show_snackbar.dart';
import 'package:spa_app/functions/shared.dart';
import 'package:spa_app/models/facialbook.dart';
import 'package:spa_app/models/user.dart';
import 'package:spa_app/services/facialbook_service.dart';
import 'package:spa_app/services/user_service.dart';
import 'package:spa_app/views/user/user_update_schedule_page.dart';

class UserSchedulePage extends StatefulWidget {
  const UserSchedulePage({super.key});

  @override
  State<UserSchedulePage> createState() => _UserSchedulePageState();
}

class _UserSchedulePageState extends State<UserSchedulePage> {
  late List<Facialbook> fbList;

  update() async {}

  delete(BuildContext context, int index) async {
    await context
        .read<FacialBookService>()
        .deleteFacialBook(fbList[index].bookid)
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
    fbList = context.read<FacialBookService>().getFacialBookList ?? [];
    List<Facialbook> dueNowFb = getDueNowScedule(fbList);
    List<Facialbook> dueFb = getDueSchedule(fbList);
    List<Facialbook> overdueFb = getOverdueScehdule(fbList);

    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createText("Current Schedule"),
              dueNowFb.isEmpty
                  ? createNoSchedule()
                  : createList(dueNowFb, disableUpdate: true),
              const SizedBox(height: 20.0),
              createText("Upcoming schedule"),
              dueFb.isEmpty ? createNoSchedule() : createList(dueFb),
              const SizedBox(height: 20.0),
              createText("Past schedule"),
              overdueFb.isEmpty
                  ? createNoSchedule()
                  : createList(overdueFb, disableUpdate: true),
            ],
          ),
        ),
      ),
    );
  }

  String timeToString(TimeOfDay tod) {
    return "${tod.hourOfPeriod.toString().padLeft(2, "0")}:${tod.minute.toString().padLeft(2, "0")} ${tod.hour < 12 ? "am" : "pm"}";
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

  Widget createList(List<Facialbook> books, {bool disableUpdate = false}) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        return ScheduleCard(
          services: decodeList(books[index].services),
          date: DateFormat.yMMMd().format(books[index].appointmentDate),
          time: timeToString(books[index].appointmentTime),
          update: disableUpdate
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserUpdateSchedulePage(fb: books[index]),
                    ),
                  ).then((result) {
                    if (result == "OK") {
                      setState(() {});
                    }
                  });
                },
          delete: () => delete(context, index),
        );
      },
    );
  }
}
