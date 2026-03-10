import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_app_mobile/core/theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textMain),
          onPressed: () => context.go('/device-overview'),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.file_copy_outlined, color: AppColors.textMain), onPressed: (){}),
          IconButton(icon: const Icon(Icons.ios_share_outlined, color: AppColors.textMain), onPressed: (){}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Diagnostics', style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 24),
            
            // Large Chart Card
            Card(
              color: AppColors.primaryLight,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.monitor_heart_rounded, color: AppColors.textMain, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Text('Heartbeat', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Icon(Icons.more_horiz, color: AppColors.textMain),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text('82', style: theme.textTheme.displayMedium?.copyWith(color: AppColors.textMain, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Text('bpm', style: theme.textTheme.titleMedium),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Simple simulated Line Chart
                    SizedBox(
                      height: 100,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          minX: 0,
                          maxX: 8,
                          minY: 0,
                          maxY: 6,
                          lineBarsData: [
                            LineChartBarData(
                              spots: const [
                                FlSpot(0, 3),
                                FlSpot(1, 3),
                                FlSpot(1.5, 4),
                                FlSpot(2, 2),
                                FlSpot(2.5, 3),
                                FlSpot(4, 3),
                                FlSpot(4.5, 5),
                                FlSpot(5, 1),
                                FlSpot(5.5, 3),
                                FlSpot(8, 3),
                              ],
                              isCurved: true,
                              color: AppColors.textMain,
                              barWidth: 2,
                              isStrokeCapRound: true,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Secondary Metric Card
            Card(
              color: AppColors.successLight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.multiline_chart, color: AppColors.success, size: 16),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('851 ms', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                                Text('R-R interval', style: theme.textTheme.bodySmall),
                              ],
                            ),
                          ],
                        ),
                        const Icon(Icons.more_horiz, color: AppColors.textMain),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    // Timeline mockup
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimelineItem('851 ms'),
                         _buildTimelineItem('841 ms'),
                          _buildTimelineItem('871 ms'),
                           _buildTimelineItem('881 ms'),
                      ],
                    )
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Summary Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                     // Circular progress visualization mockup
                     Container(
                       width: 80,
                       height: 80,
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         border: Border.all(color: AppColors.primaryLight, width: 8),
                       ),
                       child: Center(
                         child: Container(
                           width: 40,
                           height: 40,
                           decoration: const BoxDecoration(
                            color: AppColors.primaryLight,
                            shape: BoxShape.circle
                           ),
                         ),
                       ),
                     ),
                     const SizedBox(width: 24),
                     
                     Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('Results', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                           const SizedBox(height: 4),
                           Text('You are calm and ready!', style: theme.textTheme.bodySmall),
                           const SizedBox(height: 12),
                           Row(
                             children: [
                               Container(
                                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                 decoration: BoxDecoration(
                                   color: AppColors.highlightLight,
                                   borderRadius: BorderRadius.circular(8),
                                 ),
                                 child: const Row(
                                   children: [
                                     CircleAvatar(radius: 3, backgroundColor: AppColors.highlight),
                                     SizedBox(width: 4),
                                     Text('Stress', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                   ],
                                 ),
                               ),
                               const SizedBox(width: 8),
                               Container(
                                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                 decoration: BoxDecoration(
                                   color: AppColors.primaryLight,
                                   borderRadius: BorderRadius.circular(8),
                                 ),
                                 child: const Row(
                                   children: [
                                     CircleAvatar(radius: 3, backgroundColor: AppColors.primary),
                                     SizedBox(width: 4),
                                     Text('Recovery', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                   ],
                                 ),
                               ),
                             ],
                           )
                         ],
                       ),
                     )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  
  Widget _buildTimelineItem(String label) {
    return Column(
      children: [
        Container(
          height: 2,
          width: 40,
          color: Colors.white,
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
