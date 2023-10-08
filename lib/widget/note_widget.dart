
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stritva/constant.dart';
import '../model/note.dart';
import '../model/emoji.dart' as em;
import '../model/note_data.dart';

class NoteWidget extends StatelessWidget {
  DateTime _selectedDay;
  NoteWidget(this._selectedDay);

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(builder: (context, noteData, child) {
      List<Note> notesForDay = [];
      noteData.notes.forEach((note) {
        if (note.dateTime.day == _selectedDay.day) {
          notesForDay.add(note);
        }
      });

      List<em.Emoji> emojiForDay = [];
      print(noteData.emoji.length);

      noteData.emoji.forEach((emoji) {
        if (emoji.day.day == _selectedDay.day) {
          emojiForDay.add(emoji);
        }
      });

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              emojiForDay.length == 0
                  ? Container(child: Text(''))
                  :
                  //add a good design to show
                  Container(
                      width: 130,
                      child: Card(
                        elevation: 4, // Add elevation for a card-like effect
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: borderColor, width: 1),
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
          notesForDay.isEmpty
              ? Container(
                  margin: EdgeInsets.all(30),
                  child: Text(
                    '',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        fontFamily: 'Montserrat'),
                  ))
              : Expanded(
                  child: ListView.builder(
                      itemCount: notesForDay.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor, width: 2),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                              visualDensity:
                                  VisualDensity(vertical: 4), //<-- SEE HERE
                              leading: CircleAvatar(
                                backgroundColor: borderColor,
                                child: Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: borderColor,
                                ),
                                onPressed: () {
                                  notesForDay.remove(notesForDay[index]);
                                  noteData.removeItem(noteData.notes[index]);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Deleted Notes!!'),
                                    backgroundColor:
                                        const Color.fromARGB(255, 240, 41, 41),
                                  ));
                                },
                              ),
                              onLongPress: () {
                                notesForDay.remove(notesForDay[index]);
                                noteData.removeItem(noteData.notes[index]);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Deleted Notes!!')));
                              },
                              selectedColor: buttonColor,
                              title: Text(
                                notesForDay[index].note,
                                style: TextStyle(color: Colors.black),
                              ),
                              titleAlignment: ListTileTitleAlignment.threeLine),
                        );
                      }),
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
