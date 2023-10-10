import 'package:flutter/foundation.dart';
import 'note.dart';
import 'emoji.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteData with ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  List<Emoji> _emoji = [];
  List<Emoji> get emoji => _emoji;

  get size => _notes.length;
  late SharedPreferences prefs;

  Future<void> getDatabase() async {
    prefs = SharedPreferences.getInstance() as SharedPreferences;
  }

  void addEmoji(Emoji emoji) {
    _emoji.removeWhere((element) => element.day == emoji.day);

    _emoji.add(emoji);


    notifyListeners();
    final emojiData = {
      'emoji': emoji.emoji,
      'emoji_name': emoji.emoji_name,
      'day': emoji.day.toString()
    };
    prefs.setStringList('emoji', [emojiData.toString()]);

  }

  void addItem(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void removeItem(Note note) {
    _notes.remove(note);
    notifyListeners();
  }
}
