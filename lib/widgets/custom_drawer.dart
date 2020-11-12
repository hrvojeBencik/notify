import 'package:flutter/material.dart';
import 'package:shopping_list/screens/calendar_screen.dart';
import 'package:shopping_list/screens/home_screen.dart';
import 'package:shopping_list/screens/shopping_list_screen.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(
              "All In One",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.check),
            title: Text("To-Do List"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_grocery_store),
            title: Text("Shopping List"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ShoppingListScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text("Calendar"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CalendarScreen.routeName);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
