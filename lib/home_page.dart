import 'package:flutter/material.dart';
import 'package:flutter_mix/calendar_animation/calendar_app.dart';
import 'package:flutter_mix/dating_page/dating_app.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _gotoAnimatedCalendarIconDemo() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CalendarApp()));
    }

    void _gotoDatingAppDemo() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => DatingApp()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter UI Experiments'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              child: Text('Animated Calendar Icon'),
              onPressed: _gotoAnimatedCalendarIconDemo,
            ),
            RaisedButton(
              child: Text('Dating App Demo'),
              onPressed: _gotoDatingAppDemo,
            ),
          ],
        ),
      ),
    );
  }
}
