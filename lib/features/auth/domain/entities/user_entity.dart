import 'package:equatable/equatable.dart';

/// **UserEntity**
/// Repräsentiert die reine Geschäftslogik eines Benutzers im System.
/// Diese Klasse ist unabhängig von Datenquellen, JSON-Formaten oder externen APIs.
class UserEntity extends Equatable {
  /// Eindeutige Benutzer-ID
  final String id;

  /// Vollständiger Name des Benutzers
  final String name;

  /// E-Mail-Adresse des Benutzers
  final String email;

  /// Inidikator, ob der Benutzer sich im Demo-Modus befindet
  final bool isDemo;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.isDemo = false,
  });

  @override
  List<Object?> get props => [id, name, email, isDemo];
}
