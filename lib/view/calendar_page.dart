import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stritva/model/note.dart';
import 'package:stritva/model/note_data.dart';
import 'package:stritva/widget/note_widget.dart';
import '../constant.dart';
import 'package:table_calendar/table_calendar.dart';
import '../model/emoji.dart';
import '../model/user_data.dart';

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

  int months = 12;

  String selectedEmoji = ' ';
  String selectedEmojiName = ' ';

  bool isMenstrualDay(DateTime day, DateTime firstMensurationDay,
      int cycleLength, int numberOfDays) {
    DateTime currentDate = firstMensurationDay;

    // Iterate through each month
    for (int i = 0; i < months; i++) {
      // Check if the given day falls within the menstrual cycle (4 days)
      for (int j = 0; j < numberOfDays; j++) {
        if (day.year == currentDate.year &&
            day.month == currentDate.month &&
            day.day == currentDate.day) {
          return true;
        }
        currentDate = currentDate.add(const Duration(days: 1));
      }
      // Move to the next month's cycle
      currentDate = currentDate.add(Duration(days: cycleLength - numberOfDays));
    }
    return false;
  }

  TextEditingController noteController = TextEditingController();

  Widget _showPopupMenu(BuildContext context, double height, double width) {
    return Container(
      height: height * 0.06651,
      width: width * 0.1655,
      decoration: BoxDecoration(
          color: buttonColor, borderRadius: BorderRadius.circular(18)),
      child: PopupMenuButton(
          offset: const Offset(0, -100),
          position: PopupMenuPosition.over,
          color: Colors.white,
          tooltip: 'Click to View Options ',
          icon: const Icon(
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
      onTap: () {
        if (position == 0) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('close')),
                    TextButton(
                        onPressed: () {
                          if (noteController.text.isEmpty) {
                          } else {
                            var data =
                                Provider.of<NoteData>(context, listen: false);

                            data.addItem(Note(
                                note: noteController.text, day: _focusedDay));

                            noteController.clear();
                          }
                          Navigator.of(context).pop();
                        },
                        child: const Text('save')),
                  ],
                  title: Text(
                    'Note',
                    style: TextStyle(color: buttonColor),
                  ),
                  content: TextField(
                    textCapitalization: TextCapitalization.words,
                    controller: noteController,
                    decoration:
                        const InputDecoration(label: Text('Add details')),
                  ),
                );
              });
        } else if (position == 1) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actions: [
                  Column(
                    children: [
                      Text(
                        "Select",
                        style: TextStyle(
                            fontSize: 22,
                            color: buttonColor,
                            fontWeight: FontWeight.bold),
                      ),
                      for (int i = 0; i < emojis.length; i++)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selectedEmoji = emojis[i];
                              selectedEmojiName = emoji_name[i];
                            });

                            //if no Emoji is selected

                            if (selectedEmoji == ' ') {
                              Navigator.of(context).pop();
                            } else {
                              var data =
                                  Provider.of<NoteData>(context, listen: false);

                              data.addEmoji(Emoji(
                                  emoji: selectedEmoji,
                                  emoji_name: selectedEmojiName,
                                  day: _focusedDay));

                              //after adding nullify all the string
                              selectedEmoji = ' ';
                              selectedEmojiName = ' ';

                              //
                              Navigator.of(context).pop();
                            }
                          },
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    emoji_name[i],
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    emojis[i],
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              );
            },
          );
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

  // ignore: annotate_overrides
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).getDataFromPrefs();
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final user = Provider.of<UserData>(context, listen: false).user;

    DateTime firstMensurationDay = user.recentPeriodDate;

    final int cycleLength = user.cycleLength;
    final int numberOfDays = user.periodLength;

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay, // Use _focusedDay as the focused day
                calendarFormat:
                    _calendarFormat, //which format like month or week
                daysOfWeekHeight: 60,
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                }, //to not change the focuse day when we reload
                headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                    formatButtonTextStyle: TextStyle(color: buttonColor),
                    formatButtonDecoration: BoxDecoration(
                      border: Border.all(color: borderColor, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    //for left icon
                    leftChevronIcon: const Icon(
                      Icons.chevron_left_rounded,
                      color: borderColor,
                    ),
                    //for right icon
                    rightChevronIcon: const Icon(
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
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },

                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    color: borderColor,
                  ),

                  //provie similar decoration for today as like other not like selected day
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: borderColorLight,
                  ),
                ),

                calendarBuilders: CalendarBuilders(
                  //need to colour using isMenstrualDay
                  defaultBuilder: (context, day, focusedDay) {
                    if (isMenstrualDay(
                        day, firstMensurationDay, cycleLength, numberOfDays)) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          day.day.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          day.day.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }
                  },
                ),

                eventLoader: (day) =>
                    Provider.of<NoteData>(context, listen: true)
                        .notes
                        .where((element) => element.day == day)
                        .toList(),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: NoteWidget(_focusedDay),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(bottom: height * 0.012, right: width * 0.024),
          child: Align(
            child: _showPopupMenu(context, height, width),
            alignment: Alignment.bottomRight,
          ),
        ),
      ],
    );
  }
}
