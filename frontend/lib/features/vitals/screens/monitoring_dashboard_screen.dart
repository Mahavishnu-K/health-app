import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_app_mobile/core/theme/app_theme.dart';
import 'package:health_app_mobile/shared_widgets/custom_bottom_nav.dart';
import 'package:health_app_mobile/shared_widgets/custom_avatar.dart';

class MonitoringDashboardScreen extends StatelessWidget {
  const MonitoringDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CustomAvatar(
                        imageUrl: 'https://i.pravatar.cc/150?img=11', 
                        radius: 20
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hello, Jacob!', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.notifications_none_rounded, size: 28)
                ],
              ),
              
              const SizedBox(height: 32),
              Text('Heart Health', style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 24),
              
              // Top large card
              Card(
                color: AppColors.successLight,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.favorite_outline, color: AppColors.success),
                            ),
                            const SizedBox(height: 16),
                            Text('Health', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('Last diagnosis of heart\n3 days ago', style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textMain.withOpacity(0.7))),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.success),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text('Diagnostic', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                      
                      // Placeholder for 3d heart anatomy image
                      Container(
                        width: 120,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.monitor_heart, size: 64, color: AppColors.success),
                      )
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Bottom Grid Row
              Row(
                children: [
                  Expanded(
                    child: _buildMetricTile(
                      context, 
                      title: 'Heart pressure',
                      value: '123 /',
                      subvalue: ' 80',
                      iconData: Icons.water_drop_outlined,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildMetricTile(
                      context, 
                      title: 'Heart rhythm',
                      value: '67',
                      subvalue: ' / min',
                      iconData: Icons.graphic_eq,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Doctor / Support Card
              Card(
                color: AppColors.highlightLight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const CustomAvatar(imageUrl: 'https://i.pravatar.cc/150?img=33', radius: 24),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Robert Fox', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                            Text('Cardiologist', style: theme.textTheme.bodySmall),
                          ],
                        ),
                      ),
                      // Action buttons
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.chat_bubble_outline, size: 20),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.phone_outlined, size: 20),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) context.go('/device-overview');
          if (index == 2) context.go('/analytics');
        },
      ),
    );
  }
  
  Widget _buildMetricTile(BuildContext context, {
    required String title,
    required String value,
    required String subvalue,
    required IconData iconData,
  }) {
    var theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Icon(iconData, color: AppColors.textMain, size: 24),
             const SizedBox(height: 24),
             Text(title, style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
             const SizedBox(height: 8),
             RichText(
               text: TextSpan(
                 style: theme.textTheme.headlineMedium?.copyWith(color: AppColors.textMain, fontWeight: FontWeight.bold),
                 children: [
                   TextSpan(text: value),
                   TextSpan(text: subvalue, style: theme.textTheme.titleMedium?.copyWith(color: AppColors.textLight)),
                 ]
               ),
             )
          ],
        ),
      ),
    );
  }
}
