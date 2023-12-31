import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stritva/constant.dart';

import '../model/note_data.dart';

class NoteWidget extends StatelessWidget {
  final DateTime _focusedDay;
  const NoteWidget(this._focusedDay);

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(builder: (context, noteData, child) {
      // Ensure that data is loaded before proceeding
      if (noteData.isDataLoaded == false) {
        return const CircularProgressIndicator(); // Display a progress indicator
      }

      // Filter notes and emojis for the specified day
      final notesForDay = noteData.notes
          .where((note) => note.day.day == _focusedDay.day)
          .toList();
      final emojiForDay = noteData.emoji
          .where((emoji) => emoji.day.day == _focusedDay.day)
          .toList();

      // String? phaseOfDay = calculateMenstrualPhase(_focusedDay)['phase'];
      // String? pregnancyChanceOfDay =
      //     calculateMenstrualPhase(_focusedDay,)['pregnancyChance'];

      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                emojiForDay.isEmpty
                    ? const Text('No emoji available')
                    : SizedBox(
                        width: 130,
                        child: Card(
                          color: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                emojiForDay[0].emoji_name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                emojiForDay[0].emoji,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                Row(
                  children: [
                    const SizedBox(width: 5),
                    representColor(buttonColor!, 'Flow'),
                    const SizedBox(width: 8),
                    representColor(borderColor, 'Focus'),
                    const SizedBox(width: 8),
                    representColor(borderColorLight, 'Today'),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            notesForDay.isEmpty
                ? Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                      'No notes available',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  )
                : SizedBox(
                    height: 400, // Set a maximum height for the notes list
                    child: ListView.builder(
                      itemCount: notesForDay.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5.0,
                            vertical: 0.0,
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
                            visualDensity: const VisualDensity(vertical: 1),
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
                              icon: const Icon(
                                Icons.delete,
                                color: borderColorLight,
                                size: 25,
                              ),
                              onPressed: () {
                                // Remove the note
                                final removedNote = notesForDay[index];
                                noteData.removeItem(removedNote);

                                // Show a snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Deleted Note: '),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                            onLongPress: () {
                              // Handle long press (e.g., delete or edit)
                            },
                            selectedTileColor: buttonColor,
                            title: Text(
                              notesForDay[index].note,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
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
          style: const TextStyle(fontSize: 10, fontFamily: 'Ubuntu'),
        ),
      ],
    );
  }
}
