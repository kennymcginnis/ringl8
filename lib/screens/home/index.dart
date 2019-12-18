import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:intl/intl.dart';
import 'package:ringl8/components/AddButton.dart';
import 'package:ringl8/components/Calender.dart';
import 'package:ringl8/components/FadeContainer.dart';
import 'package:ringl8/components/HomeTopView.dart';
import 'package:ringl8/components/ListViewContainer.dart';
import 'package:ringl8/screens/home/homeAnimation.dart';
import 'package:ringl8/screens/home/styles.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Animation<double> containerGrowAnimation;
  AnimationController _screenController;
  AnimationController _buttonController;
  Animation<double> buttonGrowAnimation;
  Animation<double> listTileWidth;
  Animation<Alignment> listSlideAnimation;
  Animation<Alignment> buttonSwingAnimation;
  Animation<EdgeInsets> listSlidePosition;
  Animation<Color> fadeScreenAnimation;
  var animateStatus = false;
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  String month = DateFormat.MMMM().format(
    DateTime.now(),
  );
  int index = DateTime.now().month;

  void _selectForward() {
    if (index < 12)
      setState(() {
        ++index;
        month = months[index - 1];
      });
  }

  void _selectBackward() {
    if (index > 1)
      setState(() {
        --index;
        month = months[index - 1];
      });
  }

  @override
  void initState() {
    super.initState();

    _screenController = AnimationController(duration: Duration(milliseconds: 2000), vsync: this);
    _buttonController = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);

    fadeScreenAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.blue,
    ).animate(
      CurvedAnimation(
        parent: _screenController,
        curve: Curves.ease,
      ),
    );
    containerGrowAnimation = CurvedAnimation(
      parent: _screenController,
      curve: Curves.easeIn,
    );

    buttonGrowAnimation = CurvedAnimation(
      parent: _screenController,
      curve: Curves.easeOut,
    );
    containerGrowAnimation.addListener(() {
      this.setState(() {});
    });
    containerGrowAnimation.addStatusListener((AnimationStatus status) {});

    listTileWidth = Tween<double>(
      begin: 1000.0,
      end: 600.0,
    ).animate(
      CurvedAnimation(
        parent: _screenController,
        curve: Interval(
          0.225,
          0.600,
          curve: Curves.bounceIn,
        ),
      ),
    );

    listSlideAnimation = AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(
      CurvedAnimation(
        parent: _screenController,
        curve: Interval(
          0.325,
          0.700,
          curve: Curves.ease,
        ),
      ),
    );
    buttonSwingAnimation = AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
    ).animate(
      CurvedAnimation(
        parent: _screenController,
        curve: Interval(
          0.225,
          0.600,
          curve: Curves.ease,
        ),
      ),
    );
    listSlidePosition = EdgeInsetsTween(
      begin: EdgeInsets.only(bottom: 16.0),
      end: EdgeInsets.only(bottom: 80.0),
    ).animate(
      CurvedAnimation(
        parent: _screenController,
        curve: Interval(
          0.325,
          0.800,
          curve: Curves.ease,
        ),
      ),
    );
    _screenController.forward();
  }

  @override
  void dispose() {
    _screenController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.3;
    Size screenSize = MediaQuery.of(context).size;

    return (WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Container(
//          width: screenSize.width,
//          height: screenSize.height,
          child: Stack(
            //alignment: buttonSwingAnimation.value,
            alignment: Alignment.bottomRight,
            children: <Widget>[
              ListView(
                shrinkWrap: _screenController.value < 1 ? false : true,
                padding: EdgeInsets.all(0.0),
                children: <Widget>[
                  HomeTopView(
                    backgroundImage: backgroundImage,
                    containerGrowAnimation: containerGrowAnimation,
                    profileImage: profileImage,
                    month: month,
                    selectBackward: _selectBackward,
                    selectForward: _selectForward,
                  ),
                  Calender(),
                  ListViewContent(
                    listSlideAnimation: listSlideAnimation,
                    listSlidePosition: listSlidePosition,
                    listTileWidth: listTileWidth,
                  )
                ],
              ),
              FadeBox(
                fadeScreenAnimation: fadeScreenAnimation,
                containerGrowAnimation: containerGrowAnimation,
              ),
              if (animateStatus)
                StaggerAnimation(buttonController: _buttonController.view)
              else
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: InkWell(
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    onTap: () {
                      setState(() {
                        animateStatus = true;
                      });
                      _playAnimation();
                    },
                    child: AddButton(
                      buttonGrowAnimation: buttonGrowAnimation,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    ));
  }
}
