import 'package:health_app_mobile/features/vitals/models/vital_model.dart';

class AlertModel {
  final String id;
  final String patientId;
  final String message;
  final String severity; // 'critical', 'warning', 'info'
  final DateTime timestamp;
  final bool isRead;

  AlertModel({
    required this.id,
    required this.patientId,
    required this.message,
    required this.severity,
    required this.timestamp,
    this.isRead = false,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      id: json['id'] as String,
      patientId: json['patient_id'] as String,
      message: json['message'] as String,
      severity: json['severity'] as String,
      timestamp: DateTime.parse(json['created_at'] as String),
      isRead: json['is_read'] as bool? ?? false,
    );
  }
}
