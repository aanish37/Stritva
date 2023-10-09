import 'package:flutter/foundation.dart';
import 'note.dart';
import 'emoji.dart';

class NoteData with ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  List<Emoji> _emoji = [];
  List<Emoji> get emoji => _emoji;

  get size => _notes.length;

  void addEmoji(Emoji emoji) {
    _emoji.removeWhere((element) => element.day == emoji.day);

  
    _emoji.add(emoji);
    notifyListeners();
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
