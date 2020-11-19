import 'package:flutter/material.dart';
import 'package:shopping_list/screens/calendar_screen.dart';
import 'package:shopping_list/screens/notes_screen.dart';
import 'package:shopping_list/screens/shopping_list_screen.dart';
import 'package:shopping_list/screens/todo_screen.dart';

class CustomDrawer extends StatelessWidget {
  Widget _buildDrawerTile(
      BuildContext context, Icon icon, String text, String routeName) {
    return Column(
      children: [
        ListTile(
          leading: icon,
          title: Text(
            text,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(routeName);
          },
        ),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "All In One",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          _buildDrawerTile(
              context, Icon(Icons.notes), 'Notes', NotesScreen.routeName),
          _buildDrawerTile(context, Icon(Icons.calendar_today), 'Calendar',
              CalendarScreen.routeName),
          _buildDrawerTile(
              context, Icon(Icons.check), 'To-Do List', ToDoScreen.routeName),
          _buildDrawerTile(context, Icon(Icons.local_grocery_store),
              'Shopping List', ShoppingListScreen.routeName),
        ],
      ),
    );
  }
}
