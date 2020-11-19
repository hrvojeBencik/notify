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
  var _shoppingListProvider;

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
      await _shoppingListProvider.fetchList();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<ShoppingList>(
      create: (context) => ShoppingList(),
      child: Consumer<ShoppingList>(
        builder: (context, provider, _) {
          _shoppingListProvider = provider;

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
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  onPressed: provider.list.isEmpty
                      ? null
                      : () {
                          provider.removeAllItems();
                          provider.removeListFromMemory();
                          provider.saveList();
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
                          provider.list.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/shopping-empty.png',
                                        width: 96,
                                        height: 96,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Your shopping list is empty",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF999FA8),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: provider.list.length,
                                  itemBuilder: (context, index) {
                                    return CustomListTile(
                                        provider.list[index], index);
                                  },
                                ),
                          // _addItem(),
                          AddItem(ShoppingListScreen.routeName,
                              (_itemController) {
                            if (_itemController.text.isNotEmpty) {
                              setState(
                                () {
                                  provider.addItem(_itemController.text);
                                  provider.saveList();

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
        },
      ),
    );
  }
}
