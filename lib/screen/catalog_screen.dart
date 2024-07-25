import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/book.dart';
import 'addbook_screen.dart';
import 'editbook_screen.dart';
import 'borrowed_books_screen.dart';

class CatalogScreen extends StatefulWidget {
  @override
  CatalogScreenState createState() => CatalogScreenState();
}

class CatalogScreenState extends State<CatalogScreen> {
  List<Book> books = [
    Book(id: '1', title: 'Book 1', author: 'Author A', genre: 'Fantasy', isAvailable: true),
    Book(id: '2', title: 'Book 2', author: 'Author B', genre: 'Sci-Fi', isAvailable: true),
    Book(id: '3', title: 'Book 3', author: 'Author C', genre: 'Mystery', isAvailable: true),
    Book(id: '4', title: 'Book 4', author: 'Author D', genre: 'Romance', isAvailable: true),
    Book(id: '5', title: 'Book 5', author: 'Author E', genre: 'Thriller', isAvailable: true),
  ];

  TextEditingController searchController = TextEditingController();
  String searchText = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Book> getFilteredBooks() {
    if (searchText.isEmpty) {
      return books;
    } else {
      return books.where((book) =>
          book.title.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
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

  void addBook(Book newBook) {
    setState(() {
      books.add(newBook);
    });
    showToast('Book added');
  }

  void editBook(Book updatedBook) {
    setState(() {
      int index = books.indexWhere((element) => element.id == updatedBook.id);
      if (index != -1) {
        books[index] = updatedBook;
      }
    });
    showToast('Book updated');
  }

  void navigateToEditScreen(Book book) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditBookScreen(
          book: book,
          onEditBook: editBook,
        ),
      ),
    );
  }


  void deleteBook(Book book) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Do you want to delete ${book.title}?'),
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
                  books.remove(book);
                });
                showToast('Deleted ${book.title}');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void borrowBook(BuildContext context, Book book) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Borrow'),
          content: Text('Do you want to borrow ${book.title}?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Borrow'),
              onPressed: () {
                setState(() {
                  book.isAvailable = false;
                });
                showToast('Borrowed ${book.title}');
                Navigator.of(context).pop();

                // Add borrowed book to the list
                borrowedBooks.add(book);

                // Navigate to BorrowedBooksScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BorrowedBooksScreen()),
                );
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
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Type to search by Title',
                      suffixIcon: searchText.isNotEmpty
                          ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            searchController.clear();
                            searchText = '';
                          });
                        },
                      )
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: getFilteredBooks().length,
                  itemBuilder: (BuildContext context, int index) {
                    Book book = getFilteredBooks()[index];
                    return ListTile(
                      title: Text(book.title),
                      subtitle: Text('by ${book.author} - ${book.genre}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              navigateToEditScreen(book); // Pass the book to be edited
                            },
                          ),

                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteBook(book);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        borrowBook(context, book);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                ),
                SizedBox(height: 70),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddBookScreen(
                          onAddBook: addBook,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    'Add Book',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
