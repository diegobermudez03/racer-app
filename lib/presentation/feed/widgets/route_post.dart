import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoutePost extends StatelessWidget {
  final String userName;
  final String initialPicUrl;
  final String finalPicUrl;
  final DateTime endingDate;
  final double avgSpeed;
  final double distance;
  final int seconds;
  final double calories;

  RoutePost({
    super.key,
    required this.userName,
    required this.initialPicUrl,
    required this.finalPicUrl,
    required this.endingDate,
    required this.avgSpeed,
    required this.distance,
    required this.seconds,
    required this.calories,
  });

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final month = months[date.month - 1];
    final day = date.day;
    final year = date.year;
    return '$month $day, $year';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.5),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User and Date Row
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  child: Text(
                    userName[0].toUpperCase(),
                    style: TextStyle(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _formatDate(endingDate),
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Image Display
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colorScheme.surfaceContainerLow,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(initialPicUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colorScheme.surfaceContainerLow,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(finalPicUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Route Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Route Details',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                _buildDetailItem(
                  context,
                  icon: Icons.speed,
                  label: 'Average Speed',
                  value: '${avgSpeed.toStringAsFixed(1)} km/h',
                ),
                _buildDetailItem(
                  context,
                  icon: Icons.directions_run,
                  label: 'Distance',
                  value: '${distance.toStringAsFixed(2)} km',
                ),
                _buildDetailItem(
                  context,
                  icon: Icons.timer,
                  label: 'Duration',
                  value: '${(seconds ~/ 60)} min',
                ),
                _buildDetailItem(
                  context,
                  icon: Icons.local_fire_department,
                  label: 'Calories Burned',
                  value: '${calories.toStringAsFixed(1)} kcal',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, {required IconData icon, required String label, required String value}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
