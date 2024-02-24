import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/export.dart';

class CryptoUtils {
  static String encryptAES(String data, String keyString, String ivString) {
    Uint8List key = utf8.encode(keyString);
    Uint8List iv = utf8.encode(ivString);
    Uint8List paddedPlaintext = _padPlaintext(utf8.encode(data));

    assert([128, 192, 256].contains(key.length * 8));
    assert(128 == iv.length * 8);
    assert(256 == paddedPlaintext.length * 8);

    final cbc = CBCBlockCipher(AESEngine())
      ..init(true, ParametersWithIV(KeyParameter(key), iv)); // true=encrypt

    // Encrypt the plaintext block-by-block

    final cipherText = Uint8List(paddedPlaintext.length); // allocate space

    var offset = 0;
    while (offset < paddedPlaintext.length) {
      offset += cbc.processBlock(paddedPlaintext, offset, cipherText, offset);
    }
    assert(offset == paddedPlaintext.length);

    return base64.encode(cipherText);
  }

  static String decryptAES(
      String encryptedData, String keyString, String ivString) {
    Uint8List key = utf8.encode(keyString);
    Uint8List iv = utf8.encode(ivString);
    Uint8List cipherText = base64Decode(encryptedData);

    assert([128, 192, 256].contains(key.length * 8));
    assert(128 == iv.length * 8);
    print("Encrypted Data: ${encryptedData.length}");
    print("Cipher Text Length: ${cipherText.length}");

    final cbc = CBCBlockCipher(AESEngine())
      ..init(false, ParametersWithIV(KeyParameter(key), iv)); // false=decrypt

    // Decrypt the cipherText block-by-block

    final paddedPlainText = Uint8List(cipherText.length); // allocate space

    var offset = 0;
    while (offset < cipherText.length) {
      offset += cbc.processBlock(cipherText, offset, paddedPlainText, offset);
    }
    assert(offset == cipherText.length);

    return utf8.decode(_unpadPlaintext(paddedPlainText));
  }

  static Uint8List _padPlaintext(Uint8List input) {
    final blockSize = 16;
    final padding = PKCS7Padding();

    final paddedLength =
        ((input.length + blockSize - 1) ~/ blockSize) * blockSize;
    final padded = Uint8List(paddedLength);

    for (var i = 0; i < input.length; i++) {
      padded[i] = input[i];
    }

    padding.addPadding(padded, input.length);

    return padded;
  }

  // Unpadding helper function
  static Uint8List _unpadPlaintext(Uint8List paddedInput) {
    final padding = PKCS7Padding();

    final unpaddedLength = padding.padCount(paddedInput);
    return paddedInput.sublist(0, paddedInput.length - unpaddedLength);
  }
}
