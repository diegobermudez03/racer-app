import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:racer_app/core/app_strings.dart';
import 'package:racer_app/entities/user_entity.dart';

class UserTile extends StatelessWidget{

  final UserEntity user;
  final File profilePicture;
  final void Function() onSeeUserPressed;
  final void Function() onChatPressed;

  UserTile({
    super.key,
    required this.user,
    required this.profilePicture,
    required this.onSeeUserPressed,
    required this.onChatPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image.file(profilePicture, width: 10,),
          Text(user.userName),
          ElevatedButton(onPressed: onSeeUserPressed, child: Text(AppStrings.seeUser)),
          ElevatedButton(onPressed: onChatPressed, child: Text(AppStrings.chatWithUser)),
        ],
      ),
    );
  }
}