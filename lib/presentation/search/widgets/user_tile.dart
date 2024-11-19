import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:racer_app/core/app_strings.dart';
import 'package:racer_app/entities/user_entity.dart';

class UserTile extends StatelessWidget {
  final UserEntity user;
  final String profilePictureUrl;
  final void Function() onSeeUserPressed;
  final void Function() onChatPressed;

  const UserTile({
    super.key,
    required this.user,
    required this.profilePictureUrl,
    required this.onSeeUserPressed,
    required this.onChatPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Picture
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              width: 50,
              height: 50,
              imageUrl: profilePictureUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 50,
                height: 50,
                color: colorScheme.surfaceContainerLow,
                child: Icon(Icons.person, color: colorScheme.onSurfaceVariant),
              ),
              errorWidget: (context, url, error) => Container(
                width: 50,
                height: 50,
                color: colorScheme.surfaceContainerLow,
                child: Icon(Icons.person, color: colorScheme.onSurfaceVariant),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.userName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.fullName,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Buttons
          IconButton(
            icon: Icon(Icons.visibility, color: colorScheme.primary),
            onPressed: onSeeUserPressed,
            tooltip: AppStrings.seeUser,
          ),
          IconButton(
            icon: Icon(Icons.chat_bubble, color: colorScheme.secondary),
            onPressed: onChatPressed,
            tooltip: AppStrings.chatWithUser,
          ),
        ],
      ),
    );
  }
}
