import 'package:flutter/material.dart';
import 'package:flutter_mix/calendar_animation/calendar_page.dart';
import 'package:flutter_mix/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Mix',
      home: HomePage(),
    );
  }
}
