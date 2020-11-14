import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingList with ChangeNotifier {
  List<String> _shoppingList = [];

  List<String> get list {
    return _shoppingList;
  }

  void addItem(String item) {
    _shoppingList.add(item);
    notifyListeners();
  }

  void removeItem(String item) {
    _shoppingList.removeWhere((element) => element == item);
    notifyListeners();
  }

  void removeAllItems() {
    _shoppingList = [];
    notifyListeners();
  }

  void saveList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('shoppingList', _shoppingList);
    notifyListeners();
  }

  void fetchList() async {
    if (_shoppingList.isEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _shoppingList = prefs.getStringList('shoppingList');
      print('fecthing');
      notifyListeners();
    }
  }

  void removeListFromMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('shoppingList', null);
  }
}
