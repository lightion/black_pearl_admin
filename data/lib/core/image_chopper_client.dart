import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:data/core/aes_request_converter.dart';
import 'package:http/io_client.dart' as http;
import 'package:core/constants/config.dart';

class ImageChopperClient {
  static ChopperClient createChopperClient() {
    final client = ChopperClient(
        baseUrl: Uri.parse(Config.api_url),
        converter: AESConverter(),
        errorConverter: JsonConverter(),
        // authenticator: ApiAuthenticator(),
        interceptors: [
          (Request request) async {
            final authToken =
                base64Encode(utf8.encode("theblackpearl:GreenWaves!1230"));
            return request.copyWith(headers: {
              'Authorization': 'Basic $authToken',
              'Content-Type': 'multipart/form-data'
            });
          },
        ],
        client: http.IOClient(
            HttpClient()..connectionTimeout = const Duration(seconds: 30)));
    return client;
  }
}
