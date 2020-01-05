import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ringl8/models/group.dart';

enum Size {
  small,
  large,
}

class GroupIcon extends StatelessWidget {
  final Group group;
  final Function onTap;
  final Size size;

  GroupIcon(this.group, {this.onTap, Size size}) : this.size = size ?? Size.large;

  @override
  Widget build(BuildContext context) {
    var isLarge = size == Size.large;
    final contentSize = MediaQuery.of(context).size;
    final iconSize = isLarge ? (contentSize.width - 60) / 3 : 50.0;
    return SizedBox(
      height: iconSize,
      width: iconSize,
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: Color(group.color ?? 0xff424242),
            border: Border.all(
              color: Color(0xffffffff),
              width: 1.0,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(isLarge ? 12.0 : 25.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: AutoSizeText(
                isLarge ? group.name : group.initials,
                style: TextStyle(fontSize: isLarge ? 50 : 20),
                textAlign: TextAlign.center,
                minFontSize: isLarge ? 18 : 8,
                maxLines: isLarge ? 3 : 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
