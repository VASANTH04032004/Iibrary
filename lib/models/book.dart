class Book {
  String id;
  String title;
  String author;
  String genre;
  bool isAvailable;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.isAvailable,
  });


  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? genre,
    bool? isAvailable,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}

// Example usage
void main() {
  // Creating a new book instance
  Book book1 = Book(
    id: '1',
    title: 'Book Title',
    author: 'Author Name',
    genre: 'Fantasy',
    isAvailable: true,
  );

  // Creating a copy of the book with a new title
  Book book2 = book1.copyWith(title: 'New Book Title');

  // Print details of both books
  print('Book 1: ${book1.title}, ${book1.author}, ${book1.genre}, ${book1.isAvailable}');
  print('Book 2: ${book2.title}, ${book2.author}, ${book2.genre}, ${book2.isAvailable}');
}

