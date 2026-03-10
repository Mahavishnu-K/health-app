// Mock/Skeleton Router

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_app_mobile/features/auth/screens/login_screen.dart';
import 'package:health_app_mobile/features/patients/screens/device_overview_screen.dart';
import 'package:health_app_mobile/features/vitals/screens/monitoring_dashboard_screen.dart';
import 'package:health_app_mobile/features/vitals/screens/analytics_screen.dart';

final router = GoRouter(
  initialLocation: '/login', // Will be determined by auth state later
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/device-overview',
      builder: (context, state) => const DeviceOverviewScreen(),
    ),
    GoRoute(
      path: '/monitoring',
      builder: (context, state) => const MonitoringDashboardScreen(),
    ),
    GoRoute(
      path: '/analytics',
      builder: (context, state) => const AnalyticsScreen(),
    ),
  ],
);
