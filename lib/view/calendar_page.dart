import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  var _selectedDay = DateTime.now();
  var _focusedDay = DateTime.now();
  var _calendarFormat = CalendarFormat.week;
 

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
          calendarFormat: _calendarFormat,
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
              // When format changes, update the focusedDay accordingly
              if (_calendarFormat == CalendarFormat.week) {
                _focusedDay =
                    _selectedDay; // Set focusedDay to selectedDay for week view
              }
            });
          },
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            
          },
        ),
      ],
    );
  }
}
