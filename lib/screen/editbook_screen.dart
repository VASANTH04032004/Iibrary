import 'package:flutter/material.dart';
import '../models/book.dart';

class EditBookScreen extends StatefulWidget {
  final Book book;

  EditBookScreen({required this.book,onEditBook});

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  late TextEditingController titleController;
  late TextEditingController authorController;
  late TextEditingController genreController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.book.title);
    authorController = TextEditingController(text: widget.book.author);
    genreController = TextEditingController(text: widget.book.genre);
  }

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    genreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: authorController,
              decoration: InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: genreController,
              decoration: InputDecoration(labelText: 'Genre'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onSaveChanges();
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void onSaveChanges() {
    print('Save Changes button pressed');
    if (titleController.text.isNotEmpty &&
        authorController.text.isNotEmpty &&
        genreController.text.isNotEmpty) {
      widget.book.title = titleController.text;
      widget.book.author = authorController.text;
      widget.book.genre = genreController.text;

      print('Book updated: ${widget.book.title}, ${widget.book.author}, ${widget.book.genre}');

      Navigator.of(context).pop(widget.book);
    } else {
      print('Validation failed: One or more fields are empty');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fill all fields'),
            duration: Duration(seconds: 2),
          ),
          );
    }
    }
}