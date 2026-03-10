import 'dart:convert';
import 'package:health_app_mobile/core/services/api_service.dart';
import 'package:health_app_mobile/features/auth/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final ApiService _apiService;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthRepository(this._apiService);

  Future<UserModel> login(String email, String password) async {
    try {
       // Hit the FastAPI backend we created earlier
       final response = await _apiService.post('/auth/login', {
         'email': email,
         'password': password
       });

       // Response from Supabase Auth via FastAPI usually contains 'access_token' in `session`
       // Adjusting based on exact schema returning from `supabase.auth.sign_in`
       final String? token = response['session'] != null 
                              ? response['session']['access_token'] 
                              : response['access_token'];
       
       if (token != null) {
          await _storage.write(key: 'jwt_token', value: token);
          final userJson = response['user'];
          return UserModel(
            id: userJson['id'],
            email: userJson['email'],
            fullName: 'Jacob Jones', // Mocked name until we fetch from `patients` table
            role: 'patient',
          );
       }
       throw Exception('Token not found in response');

    } catch (e) {
       throw Exception('Login failed: $e');
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'jwt_token');
    return token != null;
  }
}
