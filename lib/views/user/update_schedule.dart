import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_app/data_repository/assign_value.dart';
import 'package:spa_app/models/treatment.dart';
import 'package:spa_app/views/user/bottom_navigation.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:spa_app/components/show_snackbar.dart';
import 'package:spa_app/models/facialbook.dart';
import 'package:spa_app/services/facialbook_service.dart';
import 'package:spa_app/services/user_service.dart';

class UpdateFacialBookPage extends StatefulWidget {
  const UpdateFacialBookPage({super.key, this.selectedIndex});

  final int? selectedIndex;
  @override
  State<UpdateFacialBookPage> createState() => _UpdateFacialBookPageState();
}

class _UpdateFacialBookPageState extends State<UpdateFacialBookPage> {
  //declaration
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = DateTime.now().weekday == DateTime.saturday ||
      DateTime.now().weekday == DateTime.sunday;
  bool _dateSelected = true;
  bool _timeSelected = false;
  bool _btnDateTimeDisabled = true;
  bool _btnServicesDisabled = true;
  List<Treatment> treatments = AssignValue.treatment;
  List<bool> treatmentsChecked =
      List.filled(AssignValue.treatment.length, false);

  String? token; //get token for insert booking date and time into database

  @override
  void initState() {
    super.initState();
    if (widget.selectedIndex != null) {
      treatmentsChecked[widget.selectedIndex!] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _tableCalendar(theme),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                child: Center(
                  child: Text(
                    'Select Appointment Time',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            _isWeekend ? _weekendMessage(theme) : _timePicker(theme),
          ],
        ),
      ),
      bottomNavigationBar: getTmpSpaButton(
        theme: theme,
        text: "Confirm Date & Time",
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        color: _btnDateTimeDisabled ? theme.disabledColor : theme.primaryColor,
        textColor: _btnDateTimeDisabled ? theme.primaryColor : Colors.white,
        onTap: _btnDateTimeDisabled ? null : () => showSpaBottomSheet(theme),
      ),
    );
  }

  DateTime combineDateTime(DateTime dt, TimeOfDay tod) =>
      DateTime(dt.year, dt.month, dt.day, tod.hour, tod.minute);

  void showSpaBottomSheet(ThemeData theme) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0,
      barrierColor: Colors.black.withOpacity(0.2),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return FittedBox(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  bottom: 20.0,
                ),
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width - 20.0,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Services",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: treatments.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CheckboxListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              title: Text(
                                treatments[index].name,
                                style: theme.textTheme.labelLarge,
                              ),
                              value: treatmentsChecked[index],
                              onChanged: (bool? value) => setState(() {
                                treatmentsChecked[index] = value!;
                                _btnServicesDisabled =
                                    !treatmentsChecked.contains(true);
                              }),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Divider(),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                    getTmpSpaButton(
                      theme: theme,
                      text: "Confirm Appointment",
                      color: _btnServicesDisabled
                          ? theme.disabledColor
                          : theme.primaryColor,
                      textColor: _btnServicesDisabled
                          ? theme.primaryColor
                          : Colors.white,
                      onTap: _btnServicesDisabled ? null : confirmAppointment,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() => setState(() {
          treatmentsChecked = treatmentsChecked.map((e) => false).toList();
          _btnServicesDisabled = true;
        }));
  }

  Widget getTmpSpaButton({
    required ThemeData theme,
    EdgeInsets margin = EdgeInsets.zero,
    Color? color,
    Color? textColor,
    required String text,
    double textSize = 19,
    void Function()? onTap,
  }) {
    color = color ?? theme.primaryColor;
    textColor = textColor ?? Colors.white;
    return Container(
      height: 60.0,
      margin: margin,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(40.0),
        shadowColor: theme.primaryColor.withOpacity(0.3),
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(40.0),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: textSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void confirmAppointment() async {
    final userid = context.read<UserService>().getCurrentUser!.userid;
    final datePicked = removeTime(_currentDay);
    final timePicked = TimeOfDay(hour: _currentIndex!, minute: 0);
    List<String> services = [];

    if (combineDateTime(datePicked, timePicked).isBefore(DateTime.now())) {
      showSnackBar(context, "Please book an hour before seleted time.");
      return;
    }

    for (int i = 0; i < treatments.length; i++) {
      if (treatmentsChecked[i]) services.add('"${treatments[i].name}"');
    }

    String serviceString = "";
    for (String e in services) {
      serviceString += serviceString == "" ? e : ",$e";
    }

    Facialbook fb = Facialbook(
      bookid: 0,
      userid: userid,
      appointmentDate: datePicked,
      appointmentTime: timePicked,
      services: serviceString,
    );

    Navigator.pop(context);

    await context.read<FacialBookService>().makeAppointment(fb).then((result) {
      if (result != 'OK') {
        showSnackBar(context, result);
        return;
      } else {
        context
            .read<FacialBookService>()
            .bindUserFacialbook(userid)
            .then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavigation(initialIndex: 1),
            ),
          );
          showSnackBar(context, "Added successsfully");
        });
      }
    });
  }

  DateTime removeTime(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  Widget _weekendMessage(theme) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        alignment: Alignment.center,
        child: const Text(
          'Weekend is not available, please select another date',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _timePicker(theme) {
    bool isToday = _currentDay.isBefore(DateTime.now());
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          index += 9;
          return InkWell(
            splashColor: Colors.transparent,
            onTap: (isToday && index <= DateTime.now().hour)
                ? null
                : () {
                    setState(() {
                      _currentIndex = index;
                      _timeSelected = true;
                      _btnDateTimeDisabled =
                          !(_dateSelected && _timeSelected) || _isWeekend;
                    });
                  },
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1,
                    spreadRadius: 1,
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
                color: (isToday && index <= DateTime.now().hour)
                    ? theme.disabledColor
                    : _currentIndex == index
                        ? theme.primaryColor
                        : Colors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                '${index > 12 ? index - 12 : index}:00 ${index > 11 ? "PM" : "AM"}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: (isToday && index <= DateTime.now().hour)
                      ? Colors.grey
                      : _currentIndex == index
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ),
          );
        },
        childCount: 8,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.5,
      ),
    );
  }

  Widget _tableCalendar(theme) {
    return TableCalendar(
      pageJumpingEnabled: true,
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 60)),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: theme.primaryColor,
          shape: BoxShape.circle,
        ),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;

          //check if weekend is selected
          if (selectedDay.weekday == DateTime.saturday ||
              selectedDay.weekday == DateTime.sunday) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
            _btnDateTimeDisabled = true;
          } else {
            _isWeekend = false;
            _btnDateTimeDisabled =
                !(_dateSelected && _timeSelected) || _isWeekend;
          }
        });
      }),
    );
  }
}
