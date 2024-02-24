import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:core/utils/crypto_utils.dart';
import 'package:flutter/foundation.dart';

class AESConverter implements Converter {
  @override
  Request convertRequest(Request request) => encodeJson(
        applyHeader(
          request,
          contentTypeKey,
          jsonHeaders,
          override: false,
        ),
      );

  Request encodeJson(Request request) {
    final String? contentType = request.headers[contentTypeKey];

    if ((contentType?.contains(jsonHeaders) ?? false) &&
        (request.body.runtimeType != String || !isJson(request.body))) {
      return request.copyWith(body: json.encode(request.body));
    }

    return request;
  }

  String encodedBody(String data) {
    // Encode the encrypted body to avoid further encoding issues
    return base64.encode(utf8.encode(data));
  }

  String decodedBody(String data) {
    // Decode the received body before decrypting
    return utf8.decode(base64.decode(data));
  }

  @visibleForTesting
  static bool isJson(dynamic data) {
    try {
      json.decode(data);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
      Response response) {
    // Decrypt the response body using AES after receiving
    final decryptedBody = CryptoUtils.decryptAES(
      response.body.toString() ?? "",
      'ugDGdbThNSyKnADfAq0dqAI2c19XBbPE',
      '1ZmbdOqbkYFodGEX',
    );

    return response.copyWith(body: json.decode(decryptedBody));
  }
}
