import '../entities/bxm_license_entity.dart';
import '../entities/user_entity.dart';

/// **AuthRepository**
/// Definiert die Schnittstelle für Authentifizierungs- und Sitzungsoperationen.
abstract class AuthRepository {
  /// Meldet den Benutzer im Demo-Modus an und speichert die Sitzung lokal.
  Future<UserEntity> loginDemo();

  /// Ruft die aktuelle gespeicherte Benutzersitzung ab.
  Future<UserEntity?> getCurrentUser();

  /// Ruft die aktuelle gespeicherte Lizenz ab.
  Future<BxmLicenseEntity?> getCurrentLicense();

  /// Beendet die Sitzung und löscht alle lokalen Daten (Logout).
  Future<void> logout();
}
