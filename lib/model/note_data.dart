
import 'package:flutter/foundation.dart';
import 'note.dart';

class NoteData with ChangeNotifier {


  List<Note> _notes = [];
  List<Note> get notes =>  _notes;
  

  get size => _notes.length;

  void addItem(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void removeItem(Note note) {
    _notes.remove(note);
    notifyListeners();
  }
  
}
