import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// **SecureJsonStorageService**
/// Stellt einen sicheren, verschlüsselten Dateispeicher für JSON-Daten bereit.
/// Verwendet AES-256 Cbc-Verschlüsselung mit Schlüsselverwaltung im OS Keystore/Keychain
/// und unterstützt atomare Schreibvorgänge (Atomic Writes) zur Vermeidung von Datenkorruption.
class SecureJsonStorageService {
  static const String _aesKeyStorageName = 'bxm_master_aes_key_v1';
  final FlutterSecureStorage _secureStorage;
  encrypt.Encrypter? _encrypter;

  SecureJsonStorageService({FlutterSecureStorage? secureStorage})
    : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  /// Initialisiert den Verschlüsselungsdienst und lädt oder generiert den AES-Schlüssel.
  Future<void> init() async {
    String? base64Key = await _secureStorage.read(key: _aesKeyStorageName);

    if (base64Key == null) {
      final newKey = encrypt.Key.fromSecureRandom(32);
      base64Key = newKey.base64;
      await _secureStorage.write(key: _aesKeyStorageName, value: base64Key);
    }

    final key = encrypt.Key.fromBase64(base64Key);
    _encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
  }

  /// Speichert eine Map als verschlüsselte `.sec.json`-Datei mit atomarem Schreibvorgang.
  Future<void> writeJson({
    required String fileName,
    required Map<String, dynamic> data,
  }) async {
    if (_encrypter == null) await init();

    final directory = await getApplicationDocumentsDirectory();
    final sanitizeFileName = fileName
        .replaceAll('.json', '')
        .replaceAll('.sec', '');
    final finalPath = p.join(directory.path, '$sanitizeFileName.sec.json');
    final tempPath = p.join(directory.path, '$sanitizeFileName.tmp');

    final jsonString = jsonEncode(data);
    final iv = encrypt.IV.fromSecureRandom(16);
    final encrypted = _encrypter!.encrypt(jsonString, iv: iv);

    // Payload enthält den IV (Initialization Vector) + das verschlüsselte Resultat
    final payload = {'iv': iv.base64, 'data': encrypted.base64};

    final tempFile = File(tempPath);
    await tempFile.writeAsString(jsonEncode(payload), flush: true);

    // Atomares Ersetzen der Zieldatei
    await tempFile.rename(finalPath);
  }

  /// Liest und entschlüsselt eine `.sec.json`-Datei und gibt die Map zurück.
  Future<Map<String, dynamic>?> readJson({required String fileName}) async {
    if (_encrypter == null) await init();

    final directory = await getApplicationDocumentsDirectory();
    final sanitizeFileName = fileName
        .replaceAll('.json', '')
        .replaceAll('.sec', '');
    final filePath = p.join(directory.path, '$sanitizeFileName.sec.json');
    final file = File(filePath);

    if (!await file.exists()) {
      return null;
    }

    final fileContent = await file.readAsString();
    final payload = jsonDecode(fileContent) as Map<String, dynamic>;

    final iv = encrypt.IV.fromBase64(payload['iv'] as String);
    final encryptedData = encrypt.Encrypted.fromBase64(
      payload['data'] as String,
    );

    final decryptedString = _encrypter!.decrypt(encryptedData, iv: iv);
    return jsonDecode(decryptedString) as Map<String, dynamic>;
  }

  /// Löscht eine spezifische verschlüsselte Datei aus dem lokalen Speicher.
  Future<void> deleteFile({required String fileName}) async {
    final directory = await getApplicationDocumentsDirectory();
    final sanitizeFileName = fileName
        .replaceAll('.json', '')
        .replaceAll('.sec', '');
    final filePath = p.join(directory.path, '$sanitizeFileName.sec.json');
    final file = File(filePath);

    if (await file.exists()) {
      await file.delete();
    }
  }
}
