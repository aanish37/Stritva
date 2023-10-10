import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:stritva/constant.dart';
import '../model/note.dart';
import '../model/emoji.dart' as em;
import '../model/note_data.dart';
import '../model/logic.dart';

class NoteWidget extends StatelessWidget {
  final DateTime _focusedDay;
  NoteWidget(this._focusedDay);

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(builder: (context, noteData, child) {
      List<Note> notesForDay = [];
      noteData.notes.forEach((note) {
        if (note.dateTime.day == _focusedDay.day) {
          notesForDay.add(note);
        }
      });

      List<em.Emoji> emojiForDay = [];
      print(noteData.emoji.length);

      emojiForDay = noteData.emoji.where((emoji) {
        return emoji.day.day == _focusedDay.day;
      }).toList();

      String? phaseOfDay = calculateMenstrualPhase(_focusedDay)['phase'];
      String? pregnancyChanceOfDay =
          calculateMenstrualPhase(_focusedDay)['pregnancyChance'];

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              emojiForDay.length == 0
                  ? Container(child: Text(' '))
                  :
                  //add a good design to show
                  Container(
                      width: 130,
                      child: Card(
                        surfaceTintColor: Colors.white,
                        elevation: 4, // Add elevation for a card-like effect
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              emojiForDay[0].emoji_name,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                                width:
                                    15), // Add spacing between emoji name and emoji
                            Text(
                              emojiForDay[0].emoji,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    representColor(buttonColor!, 'Flow'),
                    SizedBox(width: 8),
                    representColor(borderColor, 'Focus'),
                    SizedBox(width: 8),
                    representColor(borderColorLight, 'Today'),
                    SizedBox(width: 8)
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          notesForDay.isEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    '',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        fontFamily: 'Ubuntu'),
                  ))
              : Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *
                        1, // Specify the desired height here
                    child: ListView.builder(
                      itemCount: notesForDay.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                            horizontal:
                                5.0, // Adjust the horizontal padding as needed
                            vertical:
                                0.0, // Adjust the vertical padding as needed
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 2.0,
                            vertical: 1.0,
                          ),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: borderColorLight, width: 1),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(vertical: 1), // Adjust as needed
                            leading: CircleAvatar(
                              radius: 13,
                              backgroundColor: borderColorLight,
                              child: Text(
                                (index + 1).toString(),
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 247, 233, 233),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: borderColorLight,
                                size: 25,
                              ),
                              onPressed: () {
                                notesForDay.remove(notesForDay[index]);
                                noteData.removeItem(noteData.notes[index]);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Deleted Notes!!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                            onLongPress: () {
                              notesForDay.remove(notesForDay[index]);
                              noteData.removeItem(noteData.notes[index]);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Deleted Notes!!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            selectedColor: buttonColor,
                            title: Text(
                              notesForDay[index].note,
                              style: TextStyle(color: Colors.black),
                            ),
                            titleAlignment: ListTileTitleAlignment.center,
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ],
      );
    });
  }

  Column representColor(Color color, String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 7,
          backgroundColor: color,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 10, fontFamily: 'Ubuntu'),
        ),
      ],
    );
  }
}



//code to show the phase of day and pregnancy chance of day
//  // Card(
                //   elevation: 5,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(12.0),
                //     side: BorderSide(color: borderColor, width: 1),
                //   ),
                //   child: Column(
                //     children: [
                //       Text(phaseOfDay!),
                //       Text(pregnancyChanceOfDay!),
                //     ],
                //   ),
                // ),



                ///code for indicating different phases