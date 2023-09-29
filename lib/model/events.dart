import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  const Event(this.title);

  @override
  String toString() {
    // TODO: implement toString
    return title;
  }
  //hash map maintains index table which is used for faster access of data in a list of large data

  final kEvents=LinkedHashMap<DateTime,List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  )..addAll(_kEventSource);

  final kEventSource=Map.fromIterable(List.generate(50, (index) => index),
    key: (item)=>DateTime.utc(2021, 10, index*2),
    value: (item)=>List.generate(index, (index) => Event('Event $index')),
  );      
  
  

}
