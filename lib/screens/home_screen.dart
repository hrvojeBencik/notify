import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list/models/todo_list_model.dart';
import 'package:shopping_list/widgets/add_item.dart';
import 'package:shopping_list/widgets/custom_drawer.dart';
import 'package:shopping_list/widgets/todo_list_tile.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _toDoListProvider;
  List<Map<String, dynamic>> _toDoList;

  TextEditingController _itemController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    checkForSavedToDoList();
  }

  @override
  void dispose() {
    super.dispose();
    _itemController.dispose();
  }

  void checkForSavedToDoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('toDoList') != null &&
        prefs.getStringList('toDoList').isNotEmpty) {
      await _toDoListProvider.fetchList();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _toDoListProvider = Provider.of<ToDoList>(context, listen: true);
    _toDoList = _toDoListProvider.todoList;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          "To-Do",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: _toDoList.isEmpty
                  ? null
                  : () {
                      _toDoListProvider.removeAllToDoItems();
                      _toDoListProvider.removeListFromMemory();
                    }),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  _toDoList.isEmpty
                      ? Center(
                          child: Text(
                            "Your To-Do List is Empty",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            right: 10,
                            left: 10,
                          ),
                          child: ListView.builder(
                              itemCount: _toDoList.length,
                              itemBuilder: (context, i) {
                                return ToDoListTile(_toDoList[i]['text'],
                                    _toDoList[i]['isDone'], i);
                              }),
                        ),
                  AddItem(
                    HomeScreen.routeName,
                    (_itemController) {
                      if (_itemController.text.isNotEmpty) {
                        _toDoListProvider.addToDoItem(_itemController.text);
                        _toDoListProvider.saveToDoList();
                        setState(
                          () {
                            _itemController.clear();
                          },
                        );
                      }
                    },
                  )
                ],
              ),
      ),
    );
  }
}