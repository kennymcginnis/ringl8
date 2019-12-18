import 'dart:async';

import 'package:flutter/material.dart';

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key key, this.buttonController})
      : buttonSqueezeAnimation = Tween(
          begin: 320.0,
          end: 70.0,
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: Interval(
              0.0,
              0.150,
            ),
          ),
        ),
        buttonZoomOut = Tween(
          begin: 70.0,
          end: 1000.0,
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: Interval(
              0.550,
              0.999,
              curve: Curves.bounceOut,
            ),
          ),
        ),
        containerCircleAnimation = EdgeInsetsTween(
          begin: EdgeInsets.only(bottom: 50.0),
          end: EdgeInsets.only(bottom: 0.0),
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: Interval(
              0.500,
              0.800,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final AnimationController buttonController;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation buttonSqueezeAnimation;
  final Animation buttonZoomOut;

  Future<Null> _playAnimation() async {
    try {
      await buttonController.forward();
      await buttonController.reverse();
    } on TickerCanceled {}
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Padding(
      padding: buttonZoomOut.value == 70
          ? EdgeInsets.only(bottom: 50.0)
          : containerCircleAnimation.value,
      child: InkWell(
          onTap: () {
            _playAnimation();
          },
          child: Hero(
            tag: "fade",
            child: buttonZoomOut.value <= 300
                ? Container(
                    width: buttonZoomOut.value == 70
                        ? buttonSqueezeAnimation.value
                        : buttonZoomOut.value,
                    height: buttonZoomOut.value == 70 ? 60.0 : buttonZoomOut.value,
                    alignment: FractionalOffset.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: buttonZoomOut.value < 400
                          ? BorderRadius.all(Radius.circular(30.0))
                          : BorderRadius.all(Radius.circular(0.0)),
                    ),
                    child: buttonSqueezeAnimation.value > 75.0
                        ? Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.3,
                            ),
                          )
                        : buttonZoomOut.value < 300.0
                            ? CircularProgressIndicator(
                                value: null,
                                strokeWidth: 1.0,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : null)
                : Container(
                    width: buttonZoomOut.value,
                    height: buttonZoomOut.value,
                    decoration: BoxDecoration(
                      shape: buttonZoomOut.value < 500 ? BoxShape.circle : BoxShape.rectangle,
                      color: Colors.blue,
                    ),
                  ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    buttonController.addListener(() {
      if (buttonController.isCompleted) {
        Navigator.pushNamed(context, "/home");
      }
    });
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }
}
