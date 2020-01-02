import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ringl8/models/group.dart';

class GroupIcon extends StatelessWidget {
  final Group group;
  final Function onTap;

  GroupIcon(this.group, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Color(group.color ?? 0xff424242),
          border: Border.all(
            color: Color(0xffffffff),
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: AutoSizeText(
              group.initials,
              style: TextStyle(fontSize: 50),
              textAlign: TextAlign.center,
              minFontSize: 18,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
