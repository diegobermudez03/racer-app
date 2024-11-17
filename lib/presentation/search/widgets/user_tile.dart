import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:racer_app/core/app_strings.dart';
import 'package:racer_app/entities/user_entity.dart';

class UserTile extends StatelessWidget{

  final UserEntity user;
  final String profilePictureUrl;
  final void Function() onSeeUserPressed;
  final void Function() onChatPressed;

  UserTile({
    super.key,
    required this.user,
    required this.profilePictureUrl,
    required this.onSeeUserPressed,
    required this.onChatPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: profilePictureUrl,
            placeholder: (context, url) => Icon(Icons.person),
          ),
          Text(user.userName),
          ElevatedButton(onPressed: onSeeUserPressed, child: Text(AppStrings.seeUser)),
          ElevatedButton(onPressed: onChatPressed, child: Text(AppStrings.chatWithUser)),
        ],
      ),
    );
  }
}