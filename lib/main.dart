import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/models/notes_model.dart';
import 'package:shopping_list/models/reminder_list_model.dart';
import 'package:shopping_list/screens/calendar_screen.dart';
import 'package:shopping_list/screens/notes_screen.dart';
import 'package:shopping_list/screens/shopping_list_screen.dart';
import 'package:shopping_list/screens/todo_screen.dart';

import 'screens/home_screen.dart';

void main() => runApp(ShoppingApp());

class ShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ReminderList(),
        ),
        ChangeNotifierProvider(
          create: (context) => Notes(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF001026),
          accentColor: Color(0xFF00D39B),
        ),
        initialRoute: '/',
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          ToDoScreen.routeName: (ctx) => ToDoScreen(),
          ShoppingListScreen.routeName: (ctx) => ShoppingListScreen(),
          CalendarScreen.routeName: (ctx) => CalendarScreen(),
          NotesScreen.routeName: (ctx) => NotesScreen(),
        },
      ),
    );
  }
}
