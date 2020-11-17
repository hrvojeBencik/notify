import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/models/notes_model.dart';

class AddNoteScreen extends StatefulWidget {
  final String title;
  final String note;
  final int index;
  final bool isChanging;

  AddNoteScreen([
    this.title = '/',
    this.note = '/',
    this.index = 0,
    this.isChanging = false,
  ]);
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  var _notesProvider;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isChanging) {
      if (widget.title != '/') {
        _titleController.text = widget.title;
      }
      _contentController.text = widget.note;
    }

    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
      if (!visible) {
        FocusScope.of(context).unfocus();
      }
    });
  }

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
        title: Text(widget.isChanging ? "Change note" : "Add note"),
        elevation: 0,
        actions: [
          if (widget.isChanging)
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () {
                _notesProvider.removeNote(widget.index);
                Navigator.of(context).pop();
              },
            ),
          IconButton(
            icon: Icon(Icons.save),
            color: Theme.of(context).accentColor,
            disabledColor: Theme.of(context).accentColor.withOpacity(0.2),
            onPressed: _contentController.text.trim().isNotEmpty
                ? () {
                    String _title = _titleController.text.isEmpty
                        ? '/'
                        : _titleController.text;
                    String _note = _contentController.text;
                    if (widget.isChanging) {
                      _notesProvider.updateNote(widget.index, _title, _note);
                    } else {
                      _notesProvider.addNote(_title, _note);
                    }
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
      onEditingComplete: () {
        print('editing completed');
      },
    );
  }
}
