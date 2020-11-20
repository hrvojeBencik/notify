import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list/helpers/custom_route.dart';
import 'package:shopping_list/models/notes_model.dart';
import 'package:shopping_list/screens/add_note_screen.dart';
import 'package:shopping_list/widgets/custom_drawer.dart';
import 'package:shopping_list/widgets/note_tile.dart';

class NotesScreen extends StatefulWidget {
  static const String routeName = '/notes';
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  var notesProvider;
  List<Map<String, String>> _notes;

  void _checkForSavedNotes() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('notes') != null &&
        prefs.getStringList('notes').isNotEmpty) {
      await notesProvider.fetchNotes();
    }
  }

  @override
  void initState() {
    super.initState();
    _checkForSavedNotes();
  }

  @override
  Widget build(BuildContext context) {
    notesProvider = Provider.of<Notes>(context);
    _notes = notesProvider.notes;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textScaleFactor: 1.25,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(CustomRoute.scaleFadeTransition(AddNoteScreen()));
        },
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 32,
        ),
      ),
      body: _notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/notes-empty.png',
                    width: 96,
                    height: 96,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "You don't have any notes",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF999FA8),
                    ),
                    textScaleFactor: 1.25,
                  ),
                ],
              ),
            )
          : StaggeredGridView.countBuilder(
              padding: EdgeInsets.all(20),
              crossAxisCount: 4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return NoteTile(
                  index,
                  _notes[index]['title'],
                  _notes[index]['note'],
                  () {
                    _showBottomSheet(index);
                  },
                );
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.fit(2);
              },
            ),
    );
  }

  void _showBottomSheet(int index) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  title: Text("Delete note"),
                  onTap: () {
                    notesProvider.removeNote(index);
                    notesProvider.saveNotes();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
