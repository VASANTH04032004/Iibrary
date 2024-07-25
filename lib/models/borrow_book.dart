class Book {
  String id;
  String title;
  String author;
  String genre;
  bool isAvailable;
  String? borrower;
  DateTime? borrowedDate;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    this.isAvailable = true,
    this.borrower,
    this.borrowedDate,
  });

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? genre,
    bool? isAvailable,
    String? borrower,
    DateTime? borrowedDate,
  }) {
    return Book(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        genre: genre ?? this.genre,
        isAvailable: isAvailable ?? this.isAvailable,
        borrower: borrower ?? this.borrower,
        borrowedDate: borrowedDate ?? this.borrowedDate,
        );
    }
}