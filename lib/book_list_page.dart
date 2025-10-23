import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'book_cubit.dart';
import 'book_detail_page.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(
      builder: (context, state) {
        if (state.selectedBook != null) {
          return BookDetailPage(book: state.selectedBook!);
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Book Club"),
            actions: [
              PopupMenuButton<SortType>(
                onSelected: (type) => context.read<BookCubit>().sortBooks(type),
                itemBuilder: (context) => [
                  const PopupMenuItem(value: SortType.author, child: Text("Sort by Author")),
                  const PopupMenuItem(value: SortType.title, child: Text("Sort by Title")),
                ],
              ),
            ],
          ),
          body: state.isLoading
              ? const _ShimmerPlaceholder()
              : ListView.builder(
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    final book = state.books[index];
                    return ListTile(
                      leading: Image.network(book.imageUrl,
                          width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(book.title),
                      subtitle: Text(book.author),
                      onTap: () => context.read<BookCubit>().selectBook(book),
                    );
                  },
                ),
        );
      },
    );
  }
}

class _ShimmerPlaceholder extends StatelessWidget {
  const _ShimmerPlaceholder();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(width: 50, height: 50, color: Colors.grey.shade300),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 150, height: 12, color: Colors.grey.shade300),
                const SizedBox(height: 6),
                Container(width: 100, height: 10, color: Colors.grey.shade200),
              ],
            )
          ],
        ),
      ),
    );
  }
}
