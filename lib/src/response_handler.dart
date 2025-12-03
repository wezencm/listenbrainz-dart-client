import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:listenbrainz/api_exception.dart';

class ResponseHandler {
  static T handleResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>) parser,
  ) {
    if (response.statusCode != 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      throw ApiException(
        body['code'] as int? ?? response.statusCode,
        body['error'] as String? ?? 'Unknown error',
      );
    }
    
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return parser(decoded);
  }

  static T extractPayload<T>(
    Map<String, dynamic> decoded
  ){
    if (decoded['payload'] == null) {
      throw ApiException(
        decoded['code'] as int? ?? 400,
        decoded['error'] as String? ?? 'Unknown error',
      );
    }
    return decoded['payload'];
  }
}