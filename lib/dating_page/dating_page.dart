import 'package:flutter/material.dart';
import 'package:flutter_mix/dating_page/animated_change_container.dart';
import 'package:flutter_mix/dating_page/bottom_bar.dart';
import 'package:flutter_mix/dating_page/follow_button.dart';
import 'package:flutter_mix/dating_page/resizable_column.dart';

class DatingPage extends StatefulWidget {
  @override
  _DatingPageState createState() => _DatingPageState();
}

class _DatingPageState extends State<DatingPage> {
  int _currentPage = 0;
  Color _lightGrey = Color(0xFFF7F6F8);

  // Dummy data
  List _names = ["Lauren Turner", "Theresa Franklin", "Alice Bernat"];
  List _places = ["Great Britain, London", "Germany, Munich", "France, Paris"];
  List _followers = ["1.5k", "261", "788"];
  List _posts = ["128", "99", "477"];
  List _following = ["510", "128", "672"];
  List _isFollowing = [false, false, false];

  Widget _buildCarousel() {
    return PageView(
      onPageChanged: (newPage) => setState(() {
            _currentPage = newPage;
          }),
      children: <Widget>[
        Image.asset(
          "images/dummy1.jpg",
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Image.asset(
          "images/dummy2.jpg",
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Image.asset(
          "images/dummy3.jpg",
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24),
      child: AnimatedChangeContainer(
        child: Row(
          key: ValueKey(_currentPage),
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_names[_currentPage],
                    style: Theme.of(context).textTheme.headline),
                SizedBox(height: 4),
                Text(_places[_currentPage],
                    style: Theme.of(context).textTheme.subhead),
              ],
            ),
            Expanded(child: SizedBox()),
            FollowButton(
              initialValue: _isFollowing[_currentPage],
              callback: (following) {
                _isFollowing[_currentPage] = following;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowerInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AnimatedChangeContainer(
        child: Row(
          key: ValueKey(_currentPage),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _followers[_currentPage],
                  style: Theme.of(context).textTheme.title,
                ),
                Text("followers", style: Theme.of(context).textTheme.caption),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _posts[_currentPage],
                  style: Theme.of(context).textTheme.title,
                ),
                Text("posts", style: Theme.of(context).textTheme.caption),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  _following[_currentPage],
                  style: Theme.of(context).textTheme.title,
                ),
                Text("following", style: Theme.of(context).textTheme.caption),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryImage(String asset) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          asset,
          width: 116,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCardContents() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildFollowerInfo(),
        SizedBox(height: 24),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: _lightGrey,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(36),
                  topRight: const Radius.circular(36))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTitle(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                    "Photographer at 'La Monde', blogger and freelance journalist.",
                    style: Theme.of(context).textTheme.body2),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Photos",
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 136,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    _buildGalleryImage("images/dummy1.jpg"),
                    _buildGalleryImage("images/dummy2.jpg"),
                    _buildGalleryImage("images/dummy3.jpg"),
                    _buildGalleryImage("images/dummy1.jpg"),
                    _buildGalleryImage("images/dummy2.jpg"),
                    _buildGalleryImage("images/dummy3.jpg"),
                  ],
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 120.0),
            child: ResizableColumn(
              collapsedHeight: 200,
              background: _buildCarousel(),
              body: _buildCardContents(),
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: BottomBar()),
        ],
      ),
    );
  }
}
