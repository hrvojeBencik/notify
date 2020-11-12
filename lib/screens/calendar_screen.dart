import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/custom_drawer.dart';

class CalendarScreen extends StatefulWidget {
  static const String routeName = '/calendar';
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Calendar"),
      ),
      body: Center(
        child: Text(
          "Your calendar",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
