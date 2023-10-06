import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stritva/constant.dart';
import '../model/note.dart';

import '../model/note_data.dart';

class NoteWidget extends StatelessWidget {
  DateTime _selectedDay;
  NoteWidget(this._selectedDay);

  List<Note> _notesForDay = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(builder: (context, noteData, child) {
      noteData.notes.forEach((note) {
        if (note.dateTime.day == _selectedDay.day) {
          _notesForDay.add(note);
        }
      });
      return _notesForDay.isEmpty
          ? Container(
              margin: EdgeInsets.all(30),
              child: Text(
                'Empty Field',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ))
          : ListView.builder(
              itemCount: noteData.size,
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
                      visualDensity: VisualDensity(vertical: 4), //<-- SEE HERE
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
                          noteData.removeItem(noteData.notes[index]);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Deleted Notes!!')));
                        },
                      ),
                      onLongPress: () {
                        noteData.removeItem(noteData.notes[index]);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Deleted Notes!!')));
                      },
                      selectedColor: buttonColor,
                      title: Text(
                        noteData.notes[index].note,
                        style: TextStyle(color: Colors.black),
                      ),
                      titleAlignment: ListTileTitleAlignment.threeLine),
                );
              });
    });
  }
}