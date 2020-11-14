import 'package:flutter/material.dart';
import 'package:shopping_list/screens/home_screen.dart';
import 'package:shopping_list/screens/shopping_list_screen.dart';

class AddItem extends StatefulWidget {
  final Function(TextEditingController controller) callBack;
  final String screen;

  AddItem(this.screen, this.callBack);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController _itemController = TextEditingController();
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        width: size.width,
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 30.0,
                ),
                child: TextField(
                  controller: _itemController,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: false,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    labelText: widget.screen == HomeScreen.routeName
                        ? "Add Task"
                        : "Add Item",
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor.withOpacity(0.7),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).primaryColor,
              ),
              child: IconButton(
                iconSize: 30,
                icon: Icon(
                  widget.screen == ShoppingListScreen.routeName
                      ? Icons.add_shopping_cart_outlined
                      : Icons.add,
                  size: widget.screen == ShoppingListScreen.routeName ? 24 : 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  widget.callBack(_itemController);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
