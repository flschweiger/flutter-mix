import 'package:flutter/widgets.dart';

class AnimatedChangeContainer extends StatefulWidget {
  final Widget child;

  AnimatedChangeContainer({Key key, this.child}) : super(key: key);

  @override
  _AnimatedChangeContainerState createState() =>
      _AnimatedChangeContainerState();
}

class _AnimatedChangeContainerState extends State<AnimatedChangeContainer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Key oldKey;
  Widget oldChild;

  @override
  Widget build(BuildContext context) {
    if (oldKey == null) {
      oldKey = widget.child.key;
      oldChild = widget.child;
    }

    if (oldKey != widget.child.key) {
      oldKey = widget.child.key;
      _controller.forward();
    }

    return Transform.translate(
        offset: Offset(0, 10 * _controller.value),
        child: Opacity(opacity: 1.0 - _controller.value, child: oldChild));
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 125));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          oldChild = widget.child;
          _controller.reverse();
        });
      }
    });
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
