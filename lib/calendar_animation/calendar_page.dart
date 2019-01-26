import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  ScrollController _controller;
  double _scrolledPixels = 0;

  Widget _buildListView() {
    return NotificationListener<ScrollNotification>(
      child: ListView.builder(
        itemExtent: 100,
        controller: _controller,
        itemBuilder: (context, position) => Container(
              padding: const EdgeInsets.all(8),
              child: Text('Calendar Entry No. $position'),
            ),
      ),
      onNotification: _handleScrollEvent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildListView(),
      bottomNavigationBar: Material(
        elevation: 4,
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.mail_outline, color: Colors.grey),
                onPressed: () => print('Tap!'),
              ),
              IconButton(
                icon: Icon(Icons.search, color: Colors.grey),
                onPressed: () => print('Tap!'),
              ),
              IconButton(
                icon: ScrollControlledCalendarIcon(
                  currentDay: DateTime.now().day.toString(),
                  relativeScrollPositionInPixels: _scrolledPixels,
                ),
                onPressed: _scrollToInitialPosition,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => print('Tap!')),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(initialScrollOffset: 5000);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollToInitialPosition() {
    _controller.animateTo(5000,
        duration: Duration(seconds: 1), curve: Curves.ease);
  }

  bool _handleScrollEvent(ScrollNotification notification) {
    int pixels = notification.metrics.pixels.toInt();
    setState(() {
      _scrolledPixels = (pixels - 5000) / 500.0;
    });
    return true;
  }
}

class ScrollControlledCalendarIcon extends StatelessWidget {
  ScrollControlledCalendarIcon(
      {Key key,
      @required this.currentDay,
      @required this.relativeScrollPositionInPixels})
      : super(key: key);

  static const double fanAngle = 0.15;
  static const double fanCount = 3;

  final Animatable<double> sizedAnimation =
      Tween(begin: 1.1, end: 0.7).chain(CurveTween(curve: Curves.easeIn));
  final String currentDay;
  final double relativeScrollPositionInPixels;

  Widget _buildCalendar(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      child: Stack(
        children: <Widget>[
          Image.asset(
            'images/calendar.png',
            width: 24,
            height: 24,
          ),
          Align(
            alignment: Alignment(0, 0.2),
            child: Text(
              currentDay,
              style: Theme.of(context).textTheme.body1.copyWith(
                  color: Colors.blueAccent,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSingleLayer(double offset) {
    double angle = 0;

    if (relativeScrollPositionInPixels < 0) {
      angle = ((relativeScrollPositionInPixels % fanAngle)
              .clamp(-fanAngle, fanAngle) -
          offset -
          fanAngle);
    } else {
      angle = ((relativeScrollPositionInPixels % fanAngle)
              .clamp(-fanAngle, fanAngle) +
          offset);
    }

    if ((relativeScrollPositionInPixels / offset).abs() < 1) angle = 0;
    double progress = angle.abs() / (fanAngle * fanCount);
    double opacity = 1.0 - progress;
    double size = sizedAnimation.transform(progress);

    return Transform.rotate(
      angle: angle,
      origin: Offset(0, 50),
      child: Transform.scale(
        scale: size,
        child: Container(
          decoration: BoxDecoration(
              color: Color.lerp(Colors.white, Colors.blueAccent, opacity),
              borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }

  Widget _buildLayers() {
    return SizedBox(
      width: 20,
      height: 20,
      child: Stack(
        children: <Widget>[
          _buildSingleLayer(fanAngle * 2),
          _buildSingleLayer(fanAngle * 1),
          _buildSingleLayer(fanAngle * 0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Transform.rotate(
        angle: relativeScrollPositionInPixels.clamp(-0.12, 0.12),
        origin: Offset(0, 24),
        child: Stack(
          children: <Widget>[
            Align(
              child: _buildLayers(),
              alignment: Alignment.center,
            ),
            _buildCalendar(context),
          ],
        ),
      ),
    );
  }
}
