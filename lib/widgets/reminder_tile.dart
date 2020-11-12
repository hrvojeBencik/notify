import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/models/reminder_list_model.dart';

class ReminderTile extends StatefulWidget {
  final int index;
  final String text;
  final String date;
  final String time;

  ReminderTile(this.index, this.text, this.date, this.time);
  @override
  _ReminderTileState createState() => _ReminderTileState();
}

class _ReminderTileState extends State<ReminderTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: Provider.of<ReminderList>(context).reminderList.length - 1 ==
                  widget.index
              ? 80
              : 0),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (_) {
          Provider.of<ReminderList>(context, listen: false)
              .removeReminder(widget.index);
          Provider.of<ReminderList>(context, listen: false).saveRemindersList();
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.delete,
            size: 34,
            color: Colors.white,
          ),
        ),
        child: ListTile(
          title: Text(
            widget.text,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('dd.MM.yyyy.').format(
                  DateTime.tryParse(widget.date),
                ),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                widget.time,
                style: TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}