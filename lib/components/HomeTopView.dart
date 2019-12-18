import 'package:flutter/material.dart';
import 'package:ringl8/components/MonthView.dart';
import 'package:ringl8/components/ProfileNotification.dart';

class HomeTopView extends StatelessWidget {
  final DecorationImage backgroundImage;
  final DecorationImage profileImage;
  final VoidCallback selectBackward;
  final VoidCallback selectForward;
  final String month;
  final Animation<double> containerGrowAnimation;

  HomeTopView({
    this.backgroundImage,
    this.containerGrowAnimation,
    this.month,
    this.profileImage,
    this.selectBackward,
    this.selectForward,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final Orientation orientation = MediaQuery.of(context).orientation;
    bool isLandscape = orientation == Orientation.landscape;
    return Container(
      width: screenSize.width,
      height: screenSize.height / 2.5,
      decoration: BoxDecoration(image: backgroundImage),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color.fromRGBO(110, 101, 103, 0.6),
              Color.fromRGBO(51, 51, 63, 0.9),
            ],
            stops: [0.2, 1.0],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.0, 1.0),
          ),
        ),
        child: isLandscape
            ? ListView(
                children: <Widget>[
                  Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Good Morning!",
                        style: TextStyle(
                            fontSize: 30.0,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                      ProfileNotification(
                        containerGrowAnimation: containerGrowAnimation,
                        profileImage: profileImage,
                      ),
                      MonthView(
                        month: month,
                        selectBackward: selectBackward,
                        selectForward: selectForward,
                      )
                    ],
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Good Morning!",
                    style: TextStyle(
                        fontSize: 30.0,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                  ProfileNotification(
                    containerGrowAnimation: containerGrowAnimation,
                    profileImage: profileImage,
                  ),
                  MonthView(
                    month: month,
                    selectBackward: selectBackward,
                    selectForward: selectForward,
                  )
                ],
              ),
      ),
    );
  }
}
