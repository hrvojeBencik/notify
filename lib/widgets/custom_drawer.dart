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
          ListTile(
            leading: Icon(
              Icons.check,
              size: 28,
            ),
            title: Text(
              "To-Do List",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.local_grocery_store,
              size: 28,
            ),
            title: Text(
              "Shopping List",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ShoppingListScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.calendar_today,
              size: 28,
            ),
            title: Text(
              "Calendar",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
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
