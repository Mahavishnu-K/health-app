import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_app_mobile/core/theme/app_theme.dart';
import 'package:health_app_mobile/shared_widgets/custom_bottom_nav.dart';
import 'package:health_app_mobile/shared_widgets/custom_avatar.dart';
import 'package:health_app_mobile/shared_widgets/device_status_badge.dart';

class DeviceOverviewScreen extends StatelessWidget {
  const DeviceOverviewScreen({super.key});

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
                  Stack(
                    children: [
                      const Icon(Icons.notifications_none_rounded, size: 28),
                      Positioned(
                        right: 2,
                        top: 2,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.warning,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              
              const SizedBox(height: 32),
              Text('Tracking\nyour heart', style: theme.textTheme.displaySmall?.copyWith(height: 1.1, fontWeight: FontWeight.w800)),
              
              const SizedBox(height: 32),
              
              // Main Grid area
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left narrow column
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Battery Card
                        Card(
                          color: AppColors.highlightLight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
                            child: Column(
                              children: [
                                Text('86%', style: theme.textTheme.headlineMedium?.copyWith(color: AppColors.textMain)),
                                Text('battery', style: theme.textTheme.bodySmall),
                                const SizedBox(height: 16),
                                const Icon(Icons.bolt, color: AppColors.highlight, size: 32),
                                const SizedBox(height: 8),
                                ...List.generate(5, (index) => Container(
                                  margin: const EdgeInsets.only(bottom: 4),
                                  width: 24,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: index < 4 ? AppColors.success : AppColors.border,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Right wide column (Image / Hero card)
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(24),
                        image: const DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1576243345690-4e4b79b63288?w=400&auto=format&fit=crop'),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Bottom Action Card
              Card(
                color: AppColors.primaryLight,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      // Simulated product image
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: const Icon(Icons.watch_rounded, color: Colors.white),
                      ),
                      const SizedBox(width: 20),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Customize\nyour device', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
                          ]
                        ),
                        child: const Icon(Icons.settings_outlined, color: AppColors.textMain),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
              
              // Connect Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.highlightLight,
                    foregroundColor: AppColors.textMain,
                  ),
                  onPressed: () {
                     context.go('/monitoring');
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.sensors),
                      Text('Connect   >>>'),
                      Icon(Icons.sensors),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) context.go('/monitoring');
          if (index == 2) context.go('/analytics');
        },
      ),
    );
  }
}
