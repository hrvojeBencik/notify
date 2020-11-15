import 'package:flutter/material.dart';
import 'package:shopping_list/screens/calendar_screen.dart';
import 'package:shopping_list/screens/notes_screen.dart';
import 'package:shopping_list/screens/shopping_list_screen.dart';
import 'package:shopping_list/screens/todo_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "All In One",
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGridTile(Icons.check, 'To-Do\nList', ToDoScreen.routeName),
              SizedBox(
                width: 10,
              ),
              _buildGridTile(Icons.local_grocery_store, 'Shopping\nList',
                  ShoppingListScreen.routeName),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGridTile(Icons.notes, 'Notes', NotesScreen.routeName),
              SizedBox(
                width: 10,
              ),
              _buildGridTile(
                  Icons.calendar_today, 'Calendar', CalendarScreen.routeName),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridTile(IconData icon, String text, String routeName) {
    return Container(
      width: 160,
      height: 160,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        fillColor: Colors.white,
        splashColor: Theme.of(context).accentColor,
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(routeName);
        },
      ),
    );
  }
}
