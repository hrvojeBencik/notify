import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoList with ChangeNotifier {
  List<Map<String, dynamic>> _todoList = [];

  List<Map<String, dynamic>> get todoList {
    return [..._todoList];
  }

  void addToDoItem(String text) {
    _todoList.add({
      'text': text,
      'isDone': false,
    });
    notifyListeners();
  }

  void removeToDoItem(int index) {
    _todoList.removeAt(index);
    notifyListeners();
  }

  void checkItem(int index) {
    _todoList[index]['isDone'] = !_todoList[index]['isDone'];
    saveToDoList();
    notifyListeners();
  }

  void removeAllToDoItems() {
    _todoList = [];
    notifyListeners();
  }

  void saveToDoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tempList = [];
    _todoList.forEach((element) {
      tempList.add(json.encode({
        'text': element['text'],
        'isDone': element['isDone'],
      }));
    });
    await prefs.setStringList('toDoList', tempList);
    notifyListeners();
  }

  void fetchList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tempList = prefs.getStringList('toDoList');
    tempList.forEach((element) {
      var tempData = json.decode(element);
      _todoList.add({
        'text': tempData['text'],
        'isDone': tempData['isDone'],
      });
    });
    notifyListeners();
  }

  void removeListFromMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('toDoList', null);
  }
}
