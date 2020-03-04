import 'package:avataaar_image/avataaar_image.dart';
import 'package:flutter/material.dart';
import 'package:ringl8/models/user.dart';

enum AvatarSize {
  small,
  large,
}

class UserAvatar extends StatelessWidget {
  final User user;
  final Avataaar avataaar;
  final AvatarSize size;

  UserAvatar({this.user, this.avataaar, AvatarSize size}) : this.size = size ?? AvatarSize.large;

  @override
  Widget build(BuildContext context) {
    var isLarge = size == AvatarSize.large;
    return (user?.avatar == null && avataaar == null)
        ? CircleAvatar(child: Text(user?.initials() ?? ''))
        : AvataaarImage(
            avatar: avataaar ?? Avataaar.fromJson(user.avatar),
            errorImage: Icon(Icons.error),
            placeholder: CircularProgressIndicator(),
            width: isLarge ? 128.0 : 40.0,
          );
  }
}
