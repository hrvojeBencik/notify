import 'package:flutter/material.dart';
import 'package:shopping_list/helpers/custom_route.dart';
import 'package:shopping_list/screens/add_note_screen.dart';

class AddNoteButton extends StatefulWidget {
  @override
  _AddNoteButtonState createState() => _AddNoteButtonState();
}

class _AddNoteButtonState extends State<AddNoteButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: 60,
      height: 60,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        child: Icon(
          Icons.add,
          size: 40,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(CustomRoute.scaleFadeTransition(AddNoteScreen()));
        },
      ),
    );
  }
}
