import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/custom_drawer.dart';

class NotesScreen extends StatefulWidget {
  static const String routeName = '/notes';
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "Keep your notes here!",
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).primaryColor.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
