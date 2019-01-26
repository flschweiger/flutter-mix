import 'package:flutter/material.dart';

class FollowButton extends StatefulWidget {
  final bool initialValue;
  final Function(bool isFollowing) callback;

  FollowButton({Key key, @required this.initialValue, @required this.callback})
      : super(key: key);

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool _isFollowing;

  @override
  Widget build(BuildContext context) {
    if (_isFollowing == null) _isFollowing = widget.initialValue;

    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        color: _isFollowing ? Colors.red : Colors.transparent,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(width: 3.0, color: Colors.red),
      ),
      width: _isFollowing ? 44 : 140,
      height: 44,
      child: InkWell(
        child: SizedBox.expand(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeIn,
                    opacity: _isFollowing ? 1.0 : 0.0,
                    child: Icon(Icons.person_outline, color: Colors.white)),
              ),
              Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 350),
                  opacity: _isFollowing ? 0.0 : 1.0,
                  child: Text(
                    "FOLLOW",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            _isFollowing = !_isFollowing;
            widget.callback(_isFollowing);
          });
        },
      ),
    );
  }
}
