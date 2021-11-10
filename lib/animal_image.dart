import 'package:flutter/material.dart';

class AnimalImage extends StatelessWidget {
  String imgPath;

  AnimalImage([this.imgPath = "galgo.png"]);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //do what you want here
      },
      child: CircleAvatar(
        radius: 55.0,
        backgroundImage: ExactAssetImage('assets/galgo.png'),
      ),
    );
  }
}
