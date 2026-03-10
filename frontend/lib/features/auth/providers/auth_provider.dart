import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_app_mobile/core/services/api_service.dart';
import 'package:health_app_mobile/features/auth/models/user_model.dart';
import 'package:health_app_mobile/features/auth/repository/auth_repository.dart';

// Provides the ApiService
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(baseUrl: 'http://127.0.0.1:8000'); // Or 10.0.2.2 for Android
});

// Provides the AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthRepository(apiService);
});

// Exposes the current Auth State
final authStateProvider = StateNotifierProvider<AuthNotifier, AsyncValue<UserModel?>>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthNotifier(repo);
});

class AuthNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthRepository _repo;

  AuthNotifier(this._repo) : super(const AsyncValue.loading()) {
    _checkInitialState();
  }

  Future<void> _checkInitialState() async {
    final isLoggedIn = await _repo.isLoggedIn();
    if (isLoggedIn) {
      // In a real app we would fetch the user profile here (/users/me)
      // For this demo, if token exists, we just mock a logged in user
      state = AsyncValue.data(UserModel(id: 'mock', email: 'user@example.com', fullName: 'Returning User', role: 'patient'));
    } else {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await _repo.login(email, password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    await _repo.logout();
    state = const AsyncValue.data(null);
  }
}
