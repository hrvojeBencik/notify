import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/models/shopping_list_model.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
