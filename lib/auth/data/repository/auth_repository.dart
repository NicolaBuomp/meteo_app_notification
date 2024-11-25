// lib/auth/data/repository/auth_repository.dart
import 'package:meteo_app_notification/auth/data/models/user_model.dart';

import '../models/auth_model.dart';
import '../../services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<AuthResponse> login(String email, String password) async {
    print(
        'AuthRepository: chiamata a login con email: $email e password: $password');
    final authResponse = await _authService.login(email, password);
    print('AuthRepository: risposta dal servizio: ${authResponse.toJson()}');
    return authResponse;
  }

  Future<UserModel> register(String name, String email, String password) {
    return _authService.register(name, email, password);
  }

  Future<UserModel> getUserProfile(String id) {
    return _authService.getUserProfile(id);
  }

  Future<void> verifyOtp(String email, String otpCode) {
    return _authService.verifyOtp(email, otpCode);
  }

  Future<AuthResponse> refreshToken(String refreshToken) {
    return _authService.refreshToken(refreshToken);
  }
}
