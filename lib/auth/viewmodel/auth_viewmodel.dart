// lib/auth/viewmodel/auth_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meteo_app_notification/auth/data/models/auth_model.dart';
import '../data/repository/auth_repository.dart';
import 'auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository) : super(AuthState()) {
    _loadTokens();
  }

  // lib/auth/viewmodel/auth_viewmodel.dart
  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    print('Tentativo di login con email: $email e password: $password');
    try {
      final authResponse = await _authRepository.login(email, password);
      print('Risposta del login: ${authResponse.toJson()}');
      await _saveTokens(authResponse);
      // final user = await _authRepository.getUserProfile();
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        authResponse: authResponse,
        // user: user,
      );
    } catch (e, stacktrace) {
      print('Errore durante il login: $e');
      print('Stacktrace: $stacktrace');
      state = state.copyWith(
        isLoading: false,
        error: 'Login fallito: ${e.toString()}',
      );
    }
  }

  Future<void> register(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _authRepository.register(name, email, password);
      state = state.copyWith(
        isLoading: false,
        user: user,
        // Potresti voler effettuare il login automatico dopo la registrazione
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Registrazione fallita: ${e.toString()}',
      );
    }
  }

  Future<void> logout() async {
    await _clearTokens();
    state = AuthState();
  }

  Future<void> _saveTokens(AuthResponse authResponse) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', authResponse.accessToken);
    await prefs.setString('refreshToken', authResponse.refreshToken);
  }

  Future<void> _loadTokens() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    if (accessToken != null) {
      // Aggiorna lo stato come autenticato
      state = state.copyWith(isAuthenticated: true);
      // Carica le informazioni dell'utente
      try {
        // final user = await _authRepository.getUserProfile();
        // state = state.copyWith(user: user);
      } catch (e) {
        // Gestisci eventuali errori nel caricamento del profilo
        state = state.copyWith(error: 'Errore nel caricamento del profilo');
      }
    }
  }

  Future<void> _clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
  }
}
