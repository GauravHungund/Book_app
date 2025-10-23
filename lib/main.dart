import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'book_cubit.dart';
import 'book_list_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => BookCubit(),
      child: MaterialApp(home: BookListPage()),
    ),
  );
}
