import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/models/shopping_list_model.dart';
import 'package:shopping_list/models/todo_list_model.dart';
import 'package:shopping_list/screens/calendar_screen.dart';
import 'package:shopping_list/screens/shopping_list_screen.dart';

import 'screens/home_screen.dart';

void main() => runApp(ShoppingApp());

class ShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ShoppingList(),
        ),
        ChangeNotifierProvider(
          create: (context) => ToDoList(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        initialRoute: '/home',
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          ShoppingListScreen.routeName: (ctx) => ShoppingListScreen(),
          CalendarScreen.routeName: (ctx) => CalendarScreen(),
        },
      ),
    );
  }
}
