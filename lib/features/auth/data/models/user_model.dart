import '../../domain/entities/user_entity.dart';

/// **UserModel**
/// Datenmodell zur Serialisierung und Deserialisierung von Benutzerdaten.
/// Erweitert [UserEntity] um Methoden für JSON und lokale Speicherung.
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.isDemo,
  });

  /// Erstellt eine [UserModel]-Instanz aus einem Map/JSON-Objekt.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      isDemo: json['is_demo'] as bool? ?? false,
    );
  }

  /// Konvertiert die Instanz in ein Map/JSON-Format zur lokalen Speicherung.
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'is_demo': isDemo};
  }

  /// Erstellt eine vordefinierte [UserModel]-Instanz für den Demo-Modus (Sandbox).
  factory UserModel.demo() {
    return const UserModel(
      id: 'demo_user_001',
      name: 'axnd Demo',
      email: 'axnd@gmx.ch',
      isDemo: true,
    );
  }
}
