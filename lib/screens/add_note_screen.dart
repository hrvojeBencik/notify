import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/models/notes_model.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  var _notesProvider;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _notesProvider = Provider.of<Notes>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Add note"),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            color: Theme.of(context).accentColor,
            disabledColor: Theme.of(context).accentColor.withOpacity(0.2),
            onPressed: _contentController.text.isNotEmpty
                ? () {
                    String _title = _titleController.text.isEmpty
                        ? '/'
                        : _titleController.text;
                    String _note = _contentController.text;
                    _notesProvider.addNote(_title, _note);
                    _notesProvider.saveNotes();
                    Navigator.of(context).pop();
                  }
                : null,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _titleField(),
            _contentField(),
          ],
        ),
      ),
    );
  }

  Widget _titleField() {
    return TextField(
      controller: _titleController,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.done,
      autocorrect: false,
      style: TextStyle(
        fontSize: 24,
        color: Colors.white,
      ),
      cursorColor: Theme.of(context).accentColor,
      decoration: InputDecoration(
        hintText: 'Title (optional)',
        hintStyle: TextStyle(
          fontSize: 24,
          color: Colors.white54,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _contentField() {
    return TextField(
      controller: _contentController,
      textCapitalization: TextCapitalization.sentences,
      autocorrect: false,
      enableSuggestions: false,
      maxLines: 20,
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Theme.of(context).accentColor,
      decoration: InputDecoration(
        hintText: 'Note',
        hintStyle: TextStyle(
          color: Colors.white54,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (value) {
        setState(() {});
      },
    );
  }
}
