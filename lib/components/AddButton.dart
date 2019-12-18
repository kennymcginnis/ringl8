import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Animation<double> buttonGrowAnimation;

  AddButton({this.buttonGrowAnimation});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonGrowAnimation.value * 60,
      height: buttonGrowAnimation.value * 60,
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.add,
        size: buttonGrowAnimation.value * 40.0,
        color: Colors.white,
      ),
    );
  }
}
