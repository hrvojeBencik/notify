import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list/models/shopping_list_model.dart';
import 'package:shopping_list/widgets/custom_list_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Size size;
  TextEditingController _itemController = TextEditingController();
  var shoppingListProvider;
  List<String> list;

  @override
  void initState() {
    super.initState();
    checkForSavedList();
  }

  @override
  void dispose() {
    super.dispose();
    _itemController.dispose();
  }

  void checkForSavedList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('shoppingList') == null ||
        prefs.getStringList('shoppingList').isEmpty) {
      print('List is empty!');
    } else {
      print('List is not empty!');
      setState(() {
        shoppingListProvider.fetchList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    shoppingListProvider = Provider.of<ShoppingList>(context, listen: true);
    list = shoppingListProvider.list;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shopping List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.undo_rounded,
            ),
          ),
          IconButton(
            onPressed: () {
              shoppingListProvider.removeAllItems();
              shoppingListProvider.saveList();
            },
            icon: Icon(
              Icons.delete_forever,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              list.isEmpty
                  ? Center(
                      child: Text(
                        "Your shopping list is empty.",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return CustomListTile(list[index], index);
                      },
                    ),
              _addItem(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addItem() {
    return Positioned(
      bottom: 0,
      child: Container(
        width: size.width - 20,
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 16.0,
                  top: 5,
                  bottom: 5,
                ),
                child: TextField(
                  controller: _itemController,
                  textAlignVertical: TextAlignVertical.center,
                  textCapitalization: TextCapitalization.words,
                  autocorrect: false,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    contentPadding: EdgeInsets.only(top: 30, left: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        width: 2,
                        style: BorderStyle.solid,
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.amber,
              ),
              child: IconButton(
                iconSize: 30,
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(
                    () {
                      if (_itemController.text.isNotEmpty) {
                        shoppingListProvider.addItem(_itemController.text);
                        shoppingListProvider.saveList();

                        _itemController.clear();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
