import 'package:flutter/material.dart';
import './events.dart';

class EventWidget extends StatelessWidget {
  DateTime selectedDay;
    EventWidget( {required this.selectedDay});




  late ValueNotifier<List<Event>> _selectedEvents;

  List<Event> getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void initState() {
    _selectedEvents = ValueNotifier(getEventsForDay(selectedDay));
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
