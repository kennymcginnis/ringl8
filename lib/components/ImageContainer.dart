import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final DecorationImage image;

  ImageContainer({this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      height: 250.0,
      alignment: Alignment.center,
      decoration: new BoxDecoration(
        image: image,
      ),
    );
  }
}
