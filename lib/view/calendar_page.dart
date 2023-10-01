import 'package:flutter/material.dart';
import '../constant.dart';
import 'package:table_calendar/table_calendar.dart';
import '../model/events.dart';
// import '../model/eventWidget.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

enum Options { search, upload, copy, exit }

class _CalendarPageState extends State<CalendarPage> {
  var _selectedDay = DateTime.now();
  var _focusedDay = DateTime.now();
  var _calendarFormat = CalendarFormat.month;

  DateTime _firstMensurationDay = DateTime(2023, 10, 20);
  bool _dateClicked = false;

  final int _cycleLength = 28;
  final int _numberOfDays = 4;
  int months = 12;

  // bool checkMensturalDay(DateTime day) {
  //   for (int i = 1; i < months; i++) {
  //     if (day == _firstMensurationDay.add(Duration(days: i * _cycleLength))) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  bool isMenstrualDay(DateTime day) {
    DateTime currentDate = _firstMensurationDay;
    for (int i = 0; i < _numberOfDays * months; i++) {
      if (day.year == currentDate.year &&
          day.month == currentDate.month &&
          day.day == currentDate.day) {
            

        return true;
      }
      currentDate = currentDate.add(Duration(days: _cycleLength));
    }
    return false;
  }

  Widget _showPopUpMenu(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (BuildContext context) => [
              _buildPopupMenuItem('Search', Icons.search, Options.search.index),
              _buildPopupMenuItem('Upload', Icons.upload, Options.upload.index),
              _buildPopupMenuItem('Copy', Icons.copy, Options.copy.index),
              _buildPopupMenuItem(
                  'Exit', Icons.exit_to_app, Options.exit.index),
            ]);
  }

  PopupMenuItem _buildPopupMenuItem(
      String title, IconData iconData, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            color: Colors.black,
          ),
          Text(title),
        ],
      ),
    );
  }

  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80,
        ),
        TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay, // Use _focusedDay as the focused day
          calendarFormat: _calendarFormat, //which format like month or week
          daysOfWeekHeight: 60,
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          }, //to not change the focuse day when we reload
          headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              formatButtonTextStyle: TextStyle(color: buttonColor),
              formatButtonDecoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),

              //for left icon
              leftChevronIcon: Icon(
                Icons.chevron_left_rounded,
                color: borderColor,
              ),
              //for right icon
              rightChevronIcon: Icon(
                Icons.chevron_right_rounded,
                color: borderColor,
              )),

          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
              // When format changes, update the focusedDay accordingly
              if (_calendarFormat == CalendarFormat.month) {
                _focusedDay =
                    _selectedDay; // Set focusedDay to selectedDay for week view
              }
            });
          },
          selectedDayPredicate: (day) {
            return isMenstrualDay(day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              _dateClicked = true;
            });
          },

          calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: borderColor,
          )),
        ),
        // _dateClicked
        //     ? _buildPopupMenuItem('Search', Icons.search, Options.search.index)
        //     : Container(),
        // const SizedBox(height: 8.0),
      ],
    );
  }
}
