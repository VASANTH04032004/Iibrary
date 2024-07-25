import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/book.dart';
import 'add_borrowedbook.dart';

List<Book> borrowedBooks = [];

class BorrowedBooksScreen extends StatefulWidget {
  @override
  BorrowedBooksScreenState createState() => BorrowedBooksScreenState();
}

class BorrowedBooksScreenState extends State<BorrowedBooksScreen> {
  @override
  void initState() {
    super.initState();
  }

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

  void deleteBook(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Do you want to remove this book?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  borrowedBooks.removeAt(index);
                });
                Navigator.of(context).pop();
                showToast('Book deleted');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: borrowedBooks.isEmpty
          ? Center(
        child: Text('No books borrowed yet'),
      )
          : ListView.builder(
        itemCount: borrowedBooks.length,
        itemBuilder: (context, index) {
          Book book = borrowedBooks[index];
          return ListTile(
            title: Text(book.title),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteBook(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBookScreen(
                onAddBook: (newBook) {
                  setState(() {
                    borrowedBooks.add(newBook);
                  });
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
