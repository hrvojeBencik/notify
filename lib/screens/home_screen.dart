import 'package:flutter/cupertino.dart';
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
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 128,
              height: 128,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Notify",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 82,
                color: Theme.of(context).accentColor,
              ),
              textScaleFactor: 1,
            ),
            SizedBox(
              height: 60,
            ),
            _buildGridTile(Icons.notes, 'Notes', NotesScreen.routeName),
            SizedBox(
              height: 12,
            ),
            _buildGridTile(
                Icons.calendar_today, 'Calendar', CalendarScreen.routeName),
            SizedBox(
              height: 12,
            ),
            _buildGridTile(Icons.check, 'To-Do List', ToDoScreen.routeName),
            SizedBox(
              height: 12,
            ),
            _buildGridTile(Icons.local_grocery_store, 'Shopping List',
                ShoppingListScreen.routeName),
          ],
        ),
      ),
    );
  }

  Widget _buildGridTile(IconData icon, String text, String routeName) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: RawMaterialButton(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        fillColor: Colors.white,
        splashColor: Theme.of(context).accentColor,
        elevation: 10,
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
              textScaleFactor: 1,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward,
              size: 32,
              color: Theme.of(context).accentColor,
            )
          ],
        ),
        onPressed: () {
          var screen;
          switch (routeName) {
            case NotesScreen.routeName:
              screen = NotesScreen();
              break;
            case CalendarScreen.routeName:
              screen = CalendarScreen();
              break;
            case ToDoScreen.routeName:
              screen = ToDoScreen();
              break;
            case ShoppingListScreen.routeName:
              screen = ShoppingListScreen();
              break;
          }
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => screen,
          ));
        },
      ),
    );
  }
}
