import '../../domain/entities/bxm_license_entity.dart';

/// **BxmLicenseModel**
/// Datenmodell zur Verwaltung von Lizenzdaten inklusive JSON-Konvertierung.
/// Erweitert [BxmLicenseEntity] für die Interaktion mit der Daten-Schicht.
class BxmLicenseModel extends BxmLicenseEntity {
  const BxmLicenseModel({
    required super.tenantId,
    required super.licenseKey,
    required super.serverUrl,
    required super.activeModules,
    super.isDemo,
    required super.expiresAt,
  });

  /// Erstellt eine [BxmLicenseModel]-Instanz aus einem Map/JSON-Objekt.
  factory BxmLicenseModel.fromJson(Map<String, dynamic> json) {
    return BxmLicenseModel(
      tenantId: json['tenant_id'] as String? ?? '',
      licenseKey: json['license_key'] as String? ?? '',
      serverUrl: json['server_url'] as String? ?? '',
      activeModules: List<String>.from(json['active_modules'] ?? []),
      isDemo: json['is_demo'] as bool? ?? false,
      expiresAt: DateTime.parse(
        json['expires_at'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  /// Konvertiert die Instanz in ein Map/JSON-Format zur lokalen Speicherung.
  Map<String, dynamic> toJson() {
    return {
      'tenant_id': tenantId,
      'license_key': licenseKey,
      'server_url': serverUrl,
      'active_modules': activeModules,
      'is_demo': isDemo,
      'expires_at': expiresAt.toIso8601String(),
    };
  }

  /// Erstellt eine vollständige Demo-Lizenz für die Bexio Sandbox-Umgebung.
  factory BxmLicenseModel.demo() {
    return BxmLicenseModel(
      tenantId: 'sandbox_bexio_tenant',
      licenseKey: 'DEMO-BEXIO-SANDBOX-KEY-2026',
      serverUrl: 'https://office.bexio.com/api/v2',
      activeModules: const [
        'BMXService',
        'BMXStock',
        'BMXAdresse',
        'BMXInvoice',
      ],
      isDemo: true,
      expiresAt: DateTime.now().add(const Duration(days: 365)),
    );
  }
}
