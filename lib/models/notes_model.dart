import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notes with ChangeNotifier {
  List<Map<String, String>> _notes = [];

  List<Map<String, String>> get notes {
    return [..._notes];
  }

  void addNote(String title, String note) {
    _notes.add({
      'title': title,
      'note': note,
    });
    notifyListeners();
  }

  void updateNote(int index, String title, String note) {
    _notes[index] = {
      'title': title,
      'note': note,
    };
    notifyListeners();
  }

  void removeNote(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }

  void removeAllReminders() {
    _notes = [];
    notifyListeners();
  }

  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> tempList = [];
    _notes.forEach((element) {
      tempList.add(json.encode({
        'title': element['title'],
        'note': element['note'],
      }));
    });
    await prefs.setStringList('notes', tempList);
    notifyListeners();
  }

  void fetchNotes() async {
    if (_notes.isEmpty) {
      final prefs = await SharedPreferences.getInstance();
      List<String> tempList = prefs.getStringList('notes');
      tempList.forEach((element) {
        final tempData = json.decode(element);
        _notes.add({
          'title': tempData['title'],
          'note': tempData['note'],
        });
      });
      notifyListeners();
    }
  }

  void removeListFromMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notes', null);
  }
}
