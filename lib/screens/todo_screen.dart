import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list/models/todo_list_model.dart';
import 'package:shopping_list/widgets/add_item.dart';
import 'package:shopping_list/widgets/custom_drawer.dart';
import 'package:shopping_list/widgets/todo_list_tile.dart';

class ToDoScreen extends StatefulWidget {
  static const routeName = '/to-do';
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  var _toDoListProvider;
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
    _itemController.clear();
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
    return ChangeNotifierProvider<ToDoList>(
      create: (context) => ToDoList(),
      child: Consumer<ToDoList>(
        builder: (context, provider, _) {
          _toDoListProvider = provider;
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
                    icon: Icon(
                      Icons.delete_forever,
                    ),
                    disabledColor: Colors.white.withOpacity(0.4),
                    onPressed: provider.todoList.isEmpty
                        ? null
                        : () {
                            provider.removeAllToDoItems();
                            provider.removeListFromMemory();
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
                        provider.todoList.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/todo-empty.png',
                                      width: 96,
                                      height: 96,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "You don't have any tasks",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF999FA8),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  right: 10,
                                  left: 10,
                                ),
                                child: ListView.builder(
                                    itemCount: provider.todoList.length,
                                    itemBuilder: (context, i) {
                                      return ToDoListTile(
                                          provider.todoList[i]['text'],
                                          provider.todoList[i]['isDone'],
                                          i);
                                    }),
                              ),
                        AddItem(
                          ToDoScreen.routeName,
                          (_itemController) {
                            if (_itemController.text.isNotEmpty) {
                              provider.addToDoItem(_itemController.text);
                              provider.saveToDoList();
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
        },
      ),
    );
  }
}
