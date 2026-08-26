import '../../../../core/storage/secure_json_storage_service.dart';
import '../models/bxm_license_model.dart';
import '../models/user_model.dart';

/// **AuthLocalDataSource**
/// Verantwortlich für das lokale Speichern, Lesen und Löschen von Authentifizierungsdaten
/// (Benutzerprofil und Mandantenlizenz) unter Verwendung des verschlüsselten Speichers.
class AuthLocalDataSource {
  final SecureJsonStorageService _storageService;

  static const String _userFileName = 'bxm_user_session.sec.json';
  static const String _licenseFileName = 'bxm_license_session.sec.json';

  AuthLocalDataSource({required this._storageService});

  /// Speichert die Benutzerdaten verschlüsselt auf dem Gerät.
  Future<void> cacheUser(UserModel user) async {
    await _storageService.writeJson(
      fileName: _userFileName,
      data: user.toJson(),
    );
  }

  /// Liest die gespeicherten Benutzerdaten aus. Gibt `null` zurück, wenn keine Session existiert.
  Future<UserModel?> getLastUser() async {
    final jsonMap = await _storageService.readJson(fileName: _userFileName);
    if (jsonMap == null) return null;
    return UserModel.fromJson(jsonMap);
  }

  /// Speichert die Lizenzdaten verschlüsselt auf dem Gerät.
  Future<void> cacheLicense(BxmLicenseModel license) async {
    await _storageService.writeJson(
      fileName: _licenseFileName,
      data: license.toJson(),
    );
  }

  /// Liest die gespeicherten Lizenzdaten aus. Gibt `null` zurück, wenn keine Lizenz existiert.
  Future<BxmLicenseModel?> getLastLicense() async {
    final jsonMap = await _storageService.readJson(fileName: _licenseFileName);
    if (jsonMap == null) return null;
    return BxmLicenseModel.fromJson(jsonMap);
  }

  /// Löscht alle lokalen Auth-Session-Daten (Logout).
  Future<void> clearSession() async {
    await _storageService.deleteFile(fileName: _userFileName);
    await _storageService.deleteFile(fileName: _licenseFileName);
  }
}
