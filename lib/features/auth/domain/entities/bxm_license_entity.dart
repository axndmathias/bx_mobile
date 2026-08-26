import 'package:equatable/equatable.dart';

/// **BxmLicenseEntity**
/// Repräsentiert die Lizenzinformationen des Mandanten (Bexio Tenant).
/// Enthält Details zu aktiven Modulen, Gültigkeit und Server-Konfiguration.
class BxmLicenseEntity extends Equatable {
  /// Eindeutige Mandanten-ID (Bexio Tenant ID)
  final String tenantId;

  /// Der verwendete Lizenzschlüssel
  final String licenseKey;

  /// Basis-URL für die Bexio API-Anfragen
  final String serverUrl;

  /// Liste der freigeschalteten Module (z. B. BMXStock, BMXInvoice)
  final List<String> activeModules;

  /// Indikator, ob es sich um eine Demo-Lizenz handelt
  final bool isDemo;

  /// Ablaufdatum der Lizenz
  final DateTime expiresAt;

  const BxmLicenseEntity({
    required this.tenantId,
    required this.licenseKey,
    required this.serverUrl,
    required this.activeModules,
    this.isDemo = false,
    required this.expiresAt,
  });

  @override
  List<Object?> get props => [
    tenantId,
    licenseKey,
    serverUrl,
    activeModules,
    isDemo,
    expiresAt,
  ];
}
