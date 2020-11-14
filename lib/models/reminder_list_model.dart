import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderList with ChangeNotifier {
  List<Map<String, dynamic>> _reminderList = [];

  List<Map<String, dynamic>> get reminderList {
    return [..._reminderList];
  }

  void addReminder(String text, DateTime date, String time) {
    _reminderList.add({
      'date': date.toIso8601String(),
      'text': text,
      'time': time,
    });
    notifyListeners();
  }

  void removeReminder(int index) {
    _reminderList.removeAt(index);
    notifyListeners();
  }

  void removeAllReminders() {
    _reminderList = [];
    notifyListeners();
  }

  void sortReminders() {
    _reminderList.sort((a, b) =>
        DateTime.tryParse(a['date']).compareTo(DateTime.tryParse(b['date'])));
    notifyListeners();
  }

  void saveRemindersList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> tempList = [];
    _reminderList.forEach((element) {
      tempList.add(json.encode({
        'text': element['text'],
        'date': element['date'],
        'time': element['time'],
      }));
    });
    await prefs.setStringList('reminderList', tempList);
    notifyListeners();
  }

  void fetchReminderList() async {
    if (_reminderList.isEmpty) {
      final prefs = await SharedPreferences.getInstance();
      List<String> tempList = prefs.getStringList('reminderList');
      tempList.forEach((element) {
        final tempData = json.decode(element);
        _reminderList.add({
          'text': tempData['text'],
          'time': tempData['time'],
          'date': tempData['date'],
        });
      });
      notifyListeners();
    }
  }

  void removeListFromMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('reminderList', null);
  }
}
