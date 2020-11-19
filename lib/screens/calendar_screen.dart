import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list/models/reminder_list_model.dart';
import 'package:shopping_list/widgets/custom_drawer.dart';
import 'package:shopping_list/widgets/reminder_tile.dart';

class CalendarScreen extends StatefulWidget {
  static const String routeName = '/calendar';
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  Size size;
  TextEditingController _reminderController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  var _reminderProvider;
  List<Map<String, dynamic>> _reminders;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    checkForSavedReminderList();
  }

  @override
  void dispose() {
    super.dispose();
    _reminderController.dispose();
  }

  void checkForSavedReminderList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('reminderList') != null &&
        prefs.getStringList('reminderList').isNotEmpty) {
      await _reminderProvider.fetchReminderList();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _reminderProvider = Provider.of<ReminderList>(context, listen: true);
    _reminders = _reminderProvider.reminderList;
    size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Calendar"),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildCalendarDatePicker(),
                Divider(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : _reminders.isNotEmpty
                        ? Container(
                            height: 300,
                            child: ListView.builder(
                                itemCount: _reminders.length,
                                itemBuilder: (context, i) {
                                  return ReminderTile(
                                    i,
                                    _reminders[i]['text'],
                                    _reminders[i]['date'],
                                    _reminders[i]['time'],
                                  );
                                }),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/calendar-empty.png',
                                  width: 36,
                                  height: 36,
                                ),
                                Text(
                                  "  You don't have any reminders",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF999FA8),
                                  ),
                                ),
                              ],
                            ),
                          ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                color: Theme.of(context).canvasColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd.MM.yyyy.').format(_selectedDate),
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final _selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            setState(() {
                              selectedTime = _selectedTime;
                            });
                          },
                          child: Text(
                            selectedTime != null
                                ? selectedTime.format(context)
                                : '00:00',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _reminderController,
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                                labelText: 'Add reminder',
                                labelStyle: TextStyle(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.7),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: IconButton(
                            iconSize: 30,
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (_reminderController.text.isNotEmpty) {
                                if (selectedTime == null) {
                                  selectedTime = TimeOfDay(hour: 0, minute: 0);
                                }
                                _reminderProvider.addReminder(
                                  _reminderController.text,
                                  _selectedDate,
                                  selectedTime.format(context),
                                );
                                _reminderProvider.sortReminders();
                                _reminderProvider.saveRemindersList();
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  _reminderController.clear();
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarDatePicker() {
    return CalendarDatePicker(
      initialDate: _selectedDate,
      currentDate: DateTime.now(),
      lastDate: DateTime(2101),
      firstDate: DateTime.now(),
      onDateChanged: (value) {
        setState(() {
          _selectedDate = value;
        });
      },
    );
  }
}
