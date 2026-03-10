import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:health_app_mobile/features/vitals/models/vital_model.dart';

class SupabaseRealtimeService {
  final SupabaseClient _client = Supabase.instance.client;

  // Listen to realtime insertions in the 'vitals' table for a specific patient
  Stream<VitalModel> listenToPatientVitals(String patientId) {
    return _client
        .from('vitals')
        .stream(primaryKey: ['id'])
        .eq('patient_id', patientId)
        .order('timestamp', ascending: false)
        .limit(1)
        .map((data) {
           if (data.isEmpty) throw Exception("No vitals data");
           return VitalModel.fromJson(data.first);
        });
  }
  
  // Listen to realtime alerts for a doctor/patient
  Stream<List<Map<String, dynamic>>> listenToAlerts(String targetId) {
     return _client
        .from('alerts')
        .stream(primaryKey: ['id'])
        .eq('patient_id', targetId)
        .order('created_at', ascending: false);
  }
}
