import 'package:health_app_mobile/features/auth/models/user_model.dart';
import 'package:health_app_mobile/features/vitals/models/vital_model.dart';

class PatientModel {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String deviceStatus; // 'connected', 'offline'
  final int batteryLevel;
  final VitalModel? lastVital;

  PatientModel({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.deviceStatus,
    required this.batteryLevel,
    this.lastVital,
  });
}
