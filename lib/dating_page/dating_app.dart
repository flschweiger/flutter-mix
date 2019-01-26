import 'package:flutter/material.dart';
import 'package:flutter_mix/dating_page/dating_page.dart';

TextTheme _textTheme = TextTheme(
  headline: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 2.5,
      color: Color(0xFF555454)),
  subhead:
      TextStyle(fontSize: 12, letterSpacing: 1.0, color: Color(0xFF555454)),
  title: TextStyle(
      fontSize: 16,
      letterSpacing: 1.5,
      fontWeight: FontWeight.bold,
      color: Colors.white),
  caption: TextStyle(fontSize: 16, letterSpacing: 1.0, color: Colors.white),
  body2: TextStyle(
      fontSize: 15, fontStyle: FontStyle.italic, color: Colors.black45),
  button: TextStyle(
      fontSize: 16,
      letterSpacing: 2.0,
      fontWeight: FontWeight.bold,
      color: Colors.red),
);

class DatingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: _textTheme),
      home: DatingPage(),
    );
  }
}
