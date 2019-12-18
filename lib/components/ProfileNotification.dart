import 'package:flutter/material.dart';

class ProfileNotification extends StatelessWidget {
  final Animation<double> containerGrowAnimation;
  final DecorationImage profileImage;

  ProfileNotification({this.containerGrowAnimation, this.profileImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: containerGrowAnimation.value * 35,
            height: containerGrowAnimation.value * 35,
            margin: EdgeInsets.only(left: 80.0),
            child: Center(
              child: Text(
                "3",
                style: TextStyle(
                  fontSize: containerGrowAnimation.value * 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromRGBO(80, 210, 194, 1.0),
            ),
          ),
        ],
      ),
      width: containerGrowAnimation.value * 120,
      height: containerGrowAnimation.value * 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: profileImage,
      ),
    );
  }
}
