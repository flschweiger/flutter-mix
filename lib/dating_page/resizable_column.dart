import 'package:flutter/widgets.dart';
import 'package:flutter_mix/dating_page/animated_change_container.dart';

class ResizableColumn extends StatefulWidget {
  final Widget background;
  final Widget body;
  final double collapsedHeight;
  final double collapsedPadding = 96;

  ResizableColumn(
      {Key key,
      @required this.collapsedHeight,
      @required this.background,
      @required this.body})
      : super(key: key);

  @override
  _ResizableColumnState createState() => _ResizableColumnState();
}

class _ResizableColumnState extends State<ResizableColumn>
    with SingleTickerProviderStateMixin {
  GlobalKey _bodyKey = GlobalKey();
  AnimationController _controller;
  CurvedAnimation _animation;
  Tween<double> _heightTween;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _controller.addListener(() => setState(() {}));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _heightTween = Tween(begin: widget.collapsedHeight, end: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  double get _bodyHeight {
    final RenderBox box = _bodyKey.currentContext?.findRenderObject();
    if (box != null) return box.size.height;
    return 0;
  }

  Widget _buildGestureBody() {
    return GestureDetector(
      onVerticalDragStart: _onVerticalDragStart,
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      onVerticalDragCancel: _onVerticalDragCancel,
      onTap: () {
        _heightTween.end = _bodyHeight - 48; // TODO: Introduce var for this
        if (_controller.value < 0.3) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      },
      child: AnimatedChangeContainer(
        key: _bodyKey,
        child: widget.body,
      ),
    );
  }

  Offset _dragStart;
  double _controllerStartValue;

  void _onVerticalDragStart(DragStartDetails details) {
    _heightTween.end = _bodyHeight - 48; // TODO: Introduce var for this
    _dragStart = details.globalPosition;
    _controllerStartValue = _controller.value;
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    double progress = (_dragStart.dy - details.globalPosition.dy) /
        (_bodyHeight - widget.collapsedHeight);
    progress += _controllerStartValue;
    _controller.value = progress.clamp(0.0, 1.0);
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    double velocity = details.velocity.pixelsPerSecond.dy / -10000.0;
    _controller.fling(velocity: velocity.clamp(-2.0, 2.0));
  }

  void _onVerticalDragCancel() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: widget.background,
              ),
              SizedBox(
                  height: _heightTween.evaluate(_animation) -
                      widget.collapsedPadding),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionalTranslation(
              translation: Offset(0, 1),
              child: Transform.translate(
                offset: Offset(0, -_heightTween.evaluate(_animation)),
                child: _buildGestureBody(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
