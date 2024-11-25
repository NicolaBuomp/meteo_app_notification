import 'package:meteo_app_notification/auth/data/models/auth_model.dart';
import 'package:meteo_app_notification/auth/data/models/user_model.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final AuthResponse? authResponse;
  final UserModel? user;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.authResponse,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    AuthResponse? authResponse,
    UserModel? user,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      authResponse: authResponse ?? this.authResponse,
      user: user ?? this.user,
      error: error,
    );
  }
}
