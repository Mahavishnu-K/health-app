import 'package:flutter/material.dart';
import 'package:health_app_mobile/core/theme/app_theme.dart';

enum DeviceStatus { connected, disconnected, syncing }

class DeviceStatusBadge extends StatelessWidget {
  final DeviceStatus status;
  
  const DeviceStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color getStatusColor() {
      switch (status) {
        case DeviceStatus.connected:
          return AppColors.success;
        case DeviceStatus.disconnected:
          return AppColors.critical;
        case DeviceStatus.syncing:
          return AppColors.highlight;
      }
    }

    String getStatusText() {
      switch (status) {
        case DeviceStatus.connected:
          return 'Connected';
        case DeviceStatus.disconnected:
          return 'Offline';
        case DeviceStatus.syncing:
          return 'Syncing...';
      }
    }

    final color = getStatusColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            getStatusText(),
            style: TextStyle(
              color: color.withOpacity(0.8).withAlpha(200), // Darken slightly for readability
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
