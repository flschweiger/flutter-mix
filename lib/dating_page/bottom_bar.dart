import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 128,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(34),
              topRight: const Radius.circular(34))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () => print("Yay!"),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => print("Yay!"),
          ),
          FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.red,
            onPressed: () => print("Yay!"),
          ),
          IconButton(
            icon: Icon(Icons.alarm),
            onPressed: () => print("Yay!"),
          ),
          IconButton(
            icon: Icon(Icons.crop_original),
            onPressed: () => print("Yay!"),
          ),
        ],
      ),
    );
  }
}
