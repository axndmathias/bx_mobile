import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// **LoginDemoUseCase**
/// Verwaltet die Geschäftslogik zur Anmeldung im Demo-Modus (Sandbox).
class LoginDemoUseCase {
  final AuthRepository _repository;

  LoginDemoUseCase({required this._repository});

  Future<UserEntity> call() async {
    return await _repository.loginDemo();
  }
}
