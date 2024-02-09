// utils/crypto_utils.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';

class CryptoUtils {
  static String encryptAES(String data, String key) {
    final keyBytes = utf8.encode(key);
    final iv = Uint8List.fromList(List.filled(16, 0)); // Initialization vector

    final cipher = PaddedBlockCipherImpl(
      PKCS7Padding(),
      CBCBlockCipher(AESEngine()),
    )
      ..init(
        true,
        ParametersWithIV(
          KeyParameter(Uint8List.fromList(keyBytes)),
          iv,
        ) as PaddedBlockCipherParameters<CipherParameters?, CipherParameters?>,
      );

    final encryptedBytes = cipher.process(Uint8List.fromList(utf8.encode(data)));
    return base64.encode(encryptedBytes);
  }

  static String decryptAES(String encryptedData, String key) {
    final keyBytes = utf8.encode(key);
    final iv = Uint8List.fromList(List.filled(16, 0)); // Initialization vector

    final cipher = PaddedBlockCipherImpl(
      PKCS7Padding(),
      CBCBlockCipher(AESEngine()),
    )
      ..init(
        false,
        ParametersWithIV(
          KeyParameter(Uint8List.fromList(keyBytes)),
          iv,
        ) as PaddedBlockCipherParameters<CipherParameters?, CipherParameters?>,
      );

    final decryptedBytes = cipher.process(base64.decode(encryptedData));
    return utf8.decode(decryptedBytes);
  }
}
