import 'package:flutter_bloc/flutter_bloc.dart';
import 'book.dart';
import 'dart:async';

enum SortType { author, title }

class BookState {
  final List<Book> books;
  final Book? selectedBook;
  final SortType sortType;
  final bool isLoading;

  BookState({
    required this.books,
    this.selectedBook,
    required this.sortType,
    this.isLoading = false,
  });

  BookState copyWith({
    List<Book>? books,
    Book? selectedBook,
    SortType? sortType,
    bool? isLoading,
  }) {
    return BookState(
      books: books ?? this.books,
      selectedBook: selectedBook,
      sortType: sortType ?? this.sortType,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class BookCubit extends Cubit<BookState> {
  BookCubit()
      : super(BookState(books: [], selectedBook: null, sortType: SortType.author)) {
    _initBooks();
  }

  void _initBooks() {
    final sampleBooks = [
      Book(
        title: "The Hobbit",
        author: "J.R.R. Tolkien",
        description: "A fantasy adventure following Bilbo Baggins...",
        imageUrl: "https://picsum.photos/200",
      ),
      Book(
        title: "1984",
        author: "George Orwell",
        description: "A dystopian novel set in a totalitarian regime...",
        imageUrl: "https://picsum.photos/201",
      ),
      Book(
        title: "Brave New World",
        author: "Aldous Huxley",
        description: "A futuristic society shaped by technology and control...",
        imageUrl: "https://picsum.photos/202",
      ),
    ];

    emit(state.copyWith(books: sampleBooks));
  }

  Future<void> sortBooks(SortType type) async {
    emit(state.copyWith(isLoading: true)); // show shimmer

    await Future.delayed(const Duration(milliseconds: 700));

    final sorted = List<Book>.from(state.books);
    if (type == SortType.author) {
      sorted.sort((a, b) => a.author.compareTo(b.author));
    } else {
      sorted.sort((a, b) => a.title.compareTo(b.title));
    }

    emit(state.copyWith(books: sorted, sortType: type, isLoading: false));
  }

  void selectBook(Book book) {
    emit(state.copyWith(selectedBook: book));
  }

  Future<void> goBack() async {
    emit(state.copyWith(isLoading: true, selectedBook: null));
    await Future.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(isLoading: false));
  }
}
