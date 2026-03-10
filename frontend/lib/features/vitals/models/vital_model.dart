class VitalModel {
  final String id;
  final String patientId;
  final int heartRate;
  final int systolicPressure;
  final int diastolicPressure;
  final double spO2;
  final DateTime timestamp;

  VitalModel({
    required this.id,
    required this.patientId,
    required this.heartRate,
    required this.systolicPressure,
    required this.diastolicPressure,
    required this.spO2,
    required this.timestamp,
  });

  factory VitalModel.fromJson(Map<String, dynamic> json) {
    return VitalModel(
      id: json['id'] as String,
      patientId: json['patient_id'] as String,
      heartRate: json['heart_rate'] as int,
      systolicPressure: json['systolic_pressure'] as int? ?? 120,
      diastolicPressure: json['diastolic_pressure'] as int? ?? 80,
      spO2: (json['sp_o2'] as num?)?.toDouble() ?? 98.0,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  // Diagnostic helper based on requested logic
  String get heartStatus {
    if (heartRate < 60 || heartRate > 100) return 'critical';
    if (heartRate < 65 || heartRate > 90) return 'warning';
    return 'normal';
  }
}
