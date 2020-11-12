import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/models/todo_list_model.dart';

class ToDoListTile extends StatefulWidget {
  final String text;
  final bool isDone;
  final int index;

  ToDoListTile(this.text, this.isDone, this.index);

  @override
  _ToDoListTileState createState() => _ToDoListTileState();
}

class _ToDoListTileState extends State<ToDoListTile> {
  String _formattedText;
  bool checkBoxValue;

  @override
  void initState() {
    super.initState();
    checkBoxValue = widget.isDone;
  }

  @override
  Widget build(BuildContext context) {
    _formattedText = (widget.index + 1).toString() + ". " + widget.text;
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          Provider.of<ToDoList>(context, listen: false)
              .removeToDoItem(widget.index);
          Provider.of<ToDoList>(context, listen: false).saveToDoList();
        }
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            Icons.delete,
            size: 34,
            color: Colors.white,
          ),
        ),
      ),
      child: ListTile(
        title: Text(
          _formattedText,
          style: TextStyle(
            decoration: checkBoxValue ? TextDecoration.lineThrough : null,
            color: checkBoxValue ? Colors.grey : Colors.black,
            fontSize: 20,
          ),
        ),
        trailing: Transform.scale(
          scale: 1.4,
          child: Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: checkBoxValue,
            onChanged: (value) {
              Provider.of<ToDoList>(context, listen: false)
                  .checkItem(widget.index);
              setState(() {
                checkBoxValue = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
