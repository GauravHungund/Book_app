import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'book.dart';
import 'book_cubit.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;
  const BookDetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.read<BookCubit>().goBack(),
        ),
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(book.imageUrl, height: 200),
            ),
            const SizedBox(height: 20),
            Text(book.title, style: Theme.of(context).textTheme.titleLarge),
            Text("by ${book.author}", style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 20),
            Text(book.description, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
