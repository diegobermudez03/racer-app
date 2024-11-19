import 'package:flutter/material.dart';
import 'package:racer_app/core/app_strings.dart';
import 'package:racer_app/core/custom_navigator.dart';
import 'package:racer_app/presentation/feed/pages/feed_page.dart';

class MainFeedPage extends StatelessWidget {

  const MainFeedPage({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _printHeader(context),
        const Expanded(child: FeedPage()),
      ],
    );
  }

  Widget _printHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildCustomButton(
            context,
            label: AppStrings.search,
            icon: Icons.search,
            onPressed: () => CustomNavigator.goToSearchPage(context),
            backgroundColor: colorScheme.primaryContainer,
            textColor: colorScheme.onPrimaryContainer,
          ),
          Text(
            AppStrings.appName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          _buildCustomButton(
            context,
            label: AppStrings.chats,
            icon: Icons.chat,
            onPressed: () => CustomNavigator.goToChatsPage(context),
            backgroundColor: colorScheme.secondaryContainer,
            textColor: colorScheme.onSecondaryContainer,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24),
      splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: textColor,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
