import 'package:flutter/material.dart';
import 'package:shopping_list/screens/add_note_screen.dart';

class NoteTile extends StatelessWidget {
  final int index;
  final String title;
  final String note;
  final Function onLongPress;
  NoteTile(this.index, this.title, this.note, this.onLongPress);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(width: 2, color: Theme.of(context).primaryColor),
      ),
      splashColor: Theme.of(context).accentColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != '/')
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          Text(
            note,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
      onPressed: () {},
      onLongPress: onLongPress,
    );
  }
}
