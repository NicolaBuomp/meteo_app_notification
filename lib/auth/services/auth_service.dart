// lib/auth/services/auth_service.dart
import 'package:dio/dio.dart';
import 'package:meteo_app_notification/auth/data/models/user_model.dart';
import '../data/models/auth_model.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<AuthResponse> login(String email, String password) async {
    print(
        'AuthService: chiamata API /login con email: $email e password: $password');
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      print('AuthService: risposta dal server: ${response.data}');
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      print('AuthService: errore durante la chiamata API: $e');
      rethrow;
    }
  }

  Future<UserModel> register(String name, String email, String password) async {
    final response = await _dio.post(
      '/register',
      data: {'name': name, 'email': email, 'password': password},
    );
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> getUserProfile(String id) async {
    final response = await _dio.get('/users/$id');
    return UserModel.fromJson(response.data);
  }

  Future<void> verifyOtp(String email, String otpCode) async {
    await _dio.post(
      '/verify-otp',
      data: {'email': email, 'otpCode': otpCode},
    );
  }

  Future<AuthResponse> refreshToken(String refreshToken) async {
    final response = await _dio.post(
      '/refresh-token',
      data: {'refresh_token': refreshToken},
    );
    return AuthResponse.fromJson(response.data);
  }
}
