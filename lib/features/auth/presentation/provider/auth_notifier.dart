import 'package:flutter/foundation.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/get_current_user_use_case.dart';
import '../../domain/usecases/login_demo_use_case.dart';

/// **AuthStatus**
/// Mögliche Zustände des Authentifizierungsprozesses.
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

/// **AuthNotifier**
/// Verwaltet den Authentifizierungsstatus reaktiv mit ChangeNotifier.
class AuthNotifier extends ChangeNotifier {
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final LoginDemoUseCase _loginDemoUseCase;
  final AuthRepository _authRepository;

  AuthNotifier({
    required this._getCurrentUserUseCase,
    required this._loginDemoUseCase,
    required this._authRepository,
  });

  AuthStatus _status = AuthStatus.initial;
  UserEntity? _user;
  String? _errorMessage;

  AuthStatus get status => _status;
  UserEntity? get user => _user;
  String? get errorMessage => _errorMessage;

  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get isLoading => _status == AuthStatus.loading;

  /// Überprüft beim App-Start, ob eine gültige Sitzung existiert.
  Future<void> checkStoredSession() async {
    _setLoading(true);
    try {
      _user = await _getCurrentUserUseCase();
      if (_user != null) {
        _status = AuthStatus.authenticated;
      } else {
        _status = AuthStatus.unauthenticated;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _status = AuthStatus.error;
    }
    _setLoading(false);
  }

  /// Führt den Login im Demo-Modus aus.
  Future<void> loginDemo() async {
    _setLoading(true);
    try {
      _user = await _loginDemoUseCase();
      _status = AuthStatus.authenticated;
    } catch (e) {
      _errorMessage = e.toString();
      _status = AuthStatus.error;
    }
    _setLoading(false);
  }

  /// Beendet die Sitzung.
  Future<void> logout() async {
    _setLoading(true);
    try {
      await _authRepository.logout();
      _user = null;
      _status = AuthStatus.unauthenticated;
    } catch (e) {
      _errorMessage = e.toString();
      _status = AuthStatus.error;
    }
    _setLoading(false);
  }

  void _setLoading(bool loading) {
    if (loading) {
      _status = AuthStatus.loading;
    }
    notifyListeners();
  }
}
