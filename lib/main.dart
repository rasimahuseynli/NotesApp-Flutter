import 'package:flutter/material.dart';
import 'package:notes_app/providers/provider.dart';
import 'package:notes_app/screens/notes_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InputTextProvider>(
      create: (context) => InputTextProvider(),
      child: const MaterialApp(
        home: NotesScreen(),
      ),
    );
  }
}
