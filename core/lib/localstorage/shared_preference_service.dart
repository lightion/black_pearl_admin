import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPreferenceService {
  final _secureStorage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOption() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> writeSecureData(String key, dynamic value) async {
    await _secureStorage.write(
      key: key,
      value: value,
      aOptions: _getAndroidOption(),
    );
  }

  Future<String?> readSecureData(String key) async {
    var readData = await _secureStorage.read(
      key: key,
      aOptions: _getAndroidOption(),
    );
    return readData;
  }
}
