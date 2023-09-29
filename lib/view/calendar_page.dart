import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../model/events.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  var _selectedDay = DateTime.now();
  var _focusedDay = DateTime.now();
  var _calendarFormat = CalendarFormat.week;
 late ValueNotifier<List<Event>> _selectedEvents;


  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }


void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

   @override
  void dispose() {
    _selectedEvents.dispose();
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
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          }, //to not change the focuse day when we reload

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
          //all about events loading 

          eventLoader: (day) {
            return _getEventsForDay(day);
          },
        ),


        const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),








      ],
    );
  }
}
