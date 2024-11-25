import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../services/auth_service.dart';
import '../data/repository/auth_repository.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../viewmodel/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.0.171:3000/api', // Usa il tuo indirizzo IP locale
    connectTimeout: Duration(milliseconds: 5000), // 5 secondi
    receiveTimeout: Duration(milliseconds: 5000), // 5 secondi
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final accessToken = prefs.getString('accessToken');
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onError: (DioError e, handler) async {
        // Gestisci gli errori, ad esempio il refresh del token
        return handler.next(e);
      },
    ),
  );

  return dio;
});

final authServiceProvider = Provider<AuthService>((ref) {
  final dio = ref.read(dioProvider);
  return AuthService(dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authService = ref.read(authServiceProvider);
  return AuthRepository(authService);
});

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthViewModel(authRepository);
});
