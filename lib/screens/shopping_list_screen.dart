import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list/models/shopping_list_model.dart';
import 'package:shopping_list/widgets/add_item.dart';
import 'package:shopping_list/widgets/custom_drawer.dart';
import 'package:shopping_list/widgets/custom_list_tile.dart';

class ShoppingListScreen extends StatefulWidget {
  static const String routeName = '/shopping-list';
  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  Size size;
  TextEditingController _itemController = TextEditingController();
  var shoppingListProvider;
  List<String> list;

  bool _isLoading = true;

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
    if (prefs.getStringList('shoppingList') != null &&
        prefs.getStringList('shoppingList').isNotEmpty) {
      await shoppingListProvider.fetchList();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    shoppingListProvider = Provider.of<ShoppingList>(context, listen: true);
    list = shoppingListProvider.list;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          "Shopping List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: shoppingListProvider.list.isEmpty
                ? null
                : () {
                    shoppingListProvider.removeAllItems();
                    shoppingListProvider.removeListFromMemory();
                    shoppingListProvider.saveList();
                  },
            disabledColor: Colors.white.withOpacity(0.4),
            icon: Icon(
              Icons.delete_forever,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: size.width,
                height: size.height,
                child: Stack(
                  children: [
                    list.isEmpty
                        ? Center(
                            child: Text(
                              "Shopping List is Empty.",
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return CustomListTile(list[index], index);
                            },
                          ),
                    // _addItem(),
                    AddItem(ShoppingListScreen.routeName, (_itemController) {
                      if (_itemController.text.isNotEmpty) {
                        setState(
                          () {
                            shoppingListProvider.addItem(_itemController.text);
                            shoppingListProvider.saveList();

                            _itemController.clear();
                          },
                        );
                      }
                    })
                  ],
                ),
              ),
      ),
    );
  }
}
