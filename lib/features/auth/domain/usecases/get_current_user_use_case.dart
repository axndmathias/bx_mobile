import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// **GetCurrentUserUseCase**
/// Überprüft beim App-Start, ob bereits eine aktive verschlüsselte Benutzersitzung vorliegt.
class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase({required this._repository});

  Future<UserEntity?> call() async {
    return await _repository.getCurrentUser();
  }
}
