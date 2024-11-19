import 'dart:io';

import 'package:flutter/material.dart';
import 'package:racer_app/core/app_strings.dart';

class ProfilePictureDisplay extends StatelessWidget {
  final File? image;
  
  const ProfilePictureDisplay({
    super.key, 
    this.image
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline, width: 1.5),
      ),
      child: image == null
          ? Center(
              child: Text(
                AppStrings.noProfilePicture,
                style: TextStyle(color: colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                image!,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}