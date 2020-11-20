import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/models/shopping_list_model.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final int index;

  CustomListTile(this.title, this.index);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        Provider.of<ShoppingList>(context, listen: false).removeItem(title);
        Provider.of<ShoppingList>(context, listen: false).saveList();
      },
      background: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(
          right: 10,
          top: index == 0 ? 10 : 4,
          bottom: 4,
        ),
        padding: EdgeInsets.only(
          right: 10,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(100),
            topRight: Radius.circular(100),
          ),
        ),
        child: Icon(
          Icons.done,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      child: Container(
        margin: EdgeInsets.only(
          right: 10,
          left: 10,
          top: index == 0 ? 10 : 4,
          bottom: 10,
        ),
        child: ListTile(
          title: Text(
            (index + 1).toString() + '. ' + title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            textScaleFactor: 1.25,
          ),
        ),
      ),
    );
  }
}
