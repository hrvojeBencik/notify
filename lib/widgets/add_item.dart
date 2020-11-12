import 'package:flutter/material.dart';
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
          horizontal: 20,
        ),
        width: size.width,
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
                  textCapitalization: TextCapitalization.sentences,
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
                        width: 1,
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
                  widget.screen == ShoppingListScreen.routeName
                      ? Icons.add_shopping_cart_outlined
                      : Icons.add,
                  size: widget.screen == ShoppingListScreen.routeName ? 24 : 30,
                  color: Colors.black,
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
