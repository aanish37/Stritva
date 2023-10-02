import 'package:flutter/material.dart';
import '../constant.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

enum Options { note, emotions, exit }

class _CalendarPageState extends State<CalendarPage> {
  var _selectedDay = DateTime.now();
  var _focusedDay = DateTime.now();
  var _calendarFormat = CalendarFormat.month;

  DateTime _firstMensurationDay = DateTime(2023, 10, 20);

  final int _cycleLength = 30;
  final int _numberOfDays = 4;
  int months = 12;

  bool isMenstrualDay(DateTime day) {
    DateTime currentDate = _firstMensurationDay;

    // Iterate through each month
    for (int i = 0; i < months; i++) {
      // Check if the given day falls within the menstrual cycle (4 days)
      for (int j = 0; j < _numberOfDays; j++) {
        if (day.year == currentDate.year &&
            day.month == currentDate.month &&
            day.day == currentDate.day) {
          return true;
        }
        currentDate = currentDate.add(Duration(days: 1));
      }
      // Move to the next month's cycle
      currentDate =
          currentDate.add(Duration(days: _cycleLength - _numberOfDays));
    }
    return false;
  }

  TextEditingController? noteController;

  Widget _showPopupMenu(BuildContext context) {
    return Container(
      height: 55,
      width: 65,
      decoration: BoxDecoration(
          color: buttonColor, borderRadius: BorderRadius.circular(18)),
      child: PopupMenuButton(
          color: Colors.white,
          position: PopupMenuPosition.under,
          tooltip: 'Click to View Options ',
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          itemBuilder: (BuildContext context) => [
                _buildPopupMenuItem('  Add Note', Icons.add_comment_rounded,
                    Options.note.index),
                _buildPopupMenuItem('Add Emotions', Icons.emoji_emotions,
                    Options.emotions.index),
                _buildPopupMenuItem(
                    '        Exit', Icons.exit_to_app, Options.exit.index),
              ]),
    );
  }

  PopupMenuItem _buildPopupMenuItem(
      String title, IconData iconData, int position) {
    return PopupMenuItem(
      value: position,
      onTap: () => {
        if (position == 0)
          {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('close')),
                      TextButton(
                          onPressed: () {
                            print(noteController);
                            if (noteController == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Empty Field'),
                                duration: Duration(seconds: 2),
                              ));
                            } else {}
                            Navigator.of(context).pop();
                          },
                          child: Text('save')),
                    ],
                    title: Text(
                      'Note',
                      style: TextStyle(color: buttonColor),
                    ),
                    content: TextField(
                      controller: noteController,
                      decoration: InputDecoration(label: Text('Add details')),
                    ),
                  );
                })
          }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            color: buttonColor,
          ),
          Text(title,
              style: TextStyle(
                color: buttonColor,
              )),
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
    return Scaffold(
      floatingActionButton: _showPopupMenu(context),
      body: Column(
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
              });
            },

            calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 245, 0, 87),
                ),
                todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: borderColor,
                )),
          ),
        ],
      ),
    );
  }
}
