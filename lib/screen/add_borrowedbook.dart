import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/book.dart';

class AddBookScreen extends StatefulWidget {
  late void Function(Book) onAddBook;

  AddBookScreen({required this.onAddBook});

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController authorController = TextEditingController();
  late TextEditingController borrowerController = TextEditingController();
  late TextEditingController idController = TextEditingController();
  late TextEditingController genreController = TextEditingController();
  bool isAvailable = true; // Added for isAvailable

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'ID'),
            ),
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
            TextField(
              controller: borrowerController,
              decoration: InputDecoration(labelText: 'Borrower'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Available:'),
                Checkbox(
                  value: isAvailable,
                  onChanged: (value) {
                    setState(() {
                      isAvailable = value ?? true;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (idController.text.isNotEmpty &&
                    titleController.text.isNotEmpty &&
                    authorController.text.isNotEmpty &&
                    genreController.text.isNotEmpty &&
                    borrowerController.text.isNotEmpty) {
                  final newBook = Book(
                    id: idController.text,
                    title: titleController.text,
                    author: authorController.text,
                    genre: genreController.text,
                    isAvailable: isAvailable, // Pass isAvailable
                  );
                  widget.onAddBook(newBook);
                  Navigator.pop(context);
                } else {
                  showToast('Please fill all fields');
                }
              },
              child: Text('Add Book'),
            ),
          ],
        ),
      ),
    );
  }
}
