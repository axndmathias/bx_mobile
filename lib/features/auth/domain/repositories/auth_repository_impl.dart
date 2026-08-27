import 'package:bx_mobile/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:bx_mobile/features/auth/data/models/bxm_license_model.dart';
import 'package:bx_mobile/features/auth/data/models/user_model.dart';

import '../../domain/entities/bxm_license_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

/// **AuthRepositoryImpl**
/// Konkrete Implementierung von [AuthRepository] unter Verwendung des [AuthLocalDataSource].
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({required this._localDataSource});

  @override
  Future<UserEntity> loginDemo() async {
    final userModel = UserModel.demo();
    final licenseModel = BxmLicenseModel.demo();

    // Verschlüsselt und lokal speichern
    await _localDataSource.cacheUser(userModel);
    await _localDataSource.cacheLicense(licenseModel);

    return userModel;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return await _localDataSource.getLastUser();
  }

  @override
  Future<BxmLicenseEntity?> getCurrentLicense() async {
    return await _localDataSource.getLastLicense();
  }

  @override
  Future<void> logout() async {
    await _localDataSource.clearSession();
  }
}
