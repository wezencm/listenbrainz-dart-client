import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:listenbrainz/src/utils/rate_limiter.dart';
import 'package:listenbrainz/src/types/submission_listen.dart';
import 'package:listenbrainz/src/types/types.dart';


Future<http.Response> postToLb(
  {
    required String listenbrainzURL,
    required String endpoint,
    required Map<String, dynamic>? body,
    required String userToken,
    required http.Client httpClient,
    required RateLimiter rateLimiter,
  }
) async {
  final baseUrl = Uri.parse('$listenbrainzURL$endpoint');

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $userToken',
  };

  //final response = httpClient.post(baseUrl, headers: headers, body: jsonEncode(body));
  final response = await rateLimiter.schedule(
    () => httpClient.post(baseUrl, headers: headers, body: jsonEncode(body))
  );
  return response;
}

Future<http.Response> getFromLb(
  {
    required String listenbrainzURL,
    required String endpoint, 
    required http.Client httpClient,
    required RateLimiter rateLimiter,
    String? token,
    List<Map<String, dynamic>>? params,
  }
) async {
  // Build base URL + endpoint
  final baseUrl = Uri.parse('$listenbrainzURL$endpoint');

  final headers = {
    'Content-Type': 'application/json',
    if (token != null) 'Authorization': 'Token $token',
  };

  // Flatten params into query parameters if provided
  final queryParams = <String, dynamic>{};
  if (params != null && params.isNotEmpty) {
    for (final map in params) {
      for (final entry in map.entries) {
        final key = entry.key;
        final value = entry.value.toString();
        
        if (queryParams.containsKey(key)) {
          // Key already exists, convert to list if needed
          final existing = queryParams[key];
          if (existing is String) {
            queryParams[key] = [existing, value];
          } else if (existing is List<String>) {
            existing.add(value);
          }
        } else {
          // New key, add as string
          queryParams[key] = value;
        }
      }
    }
  }

  // Construct final URI with query parameters
  final uri = Uri(
    scheme: baseUrl.scheme,
    host: baseUrl.host,
    port: baseUrl.hasPort ? baseUrl.port : null,
    path: baseUrl.path,
    queryParameters: queryParams.isEmpty ? null : queryParams,
  );

  final response = await rateLimiter.schedule(
    () => httpClient.get(uri, headers: headers)
  );
  
  return response;
}

Future<http.Response> submitListen({
  required String listenbrainzURL,
  required dynamic listen,
  required SubmissionListenTypes type,
  required String userToken,
  required http.Client httpClient,
  required RateLimiter rateLimiter,
}) async {
  const endpoint = '/1/submit-listens';
  final url = '$listenbrainzURL$endpoint';

  const submitTypes = ['playing_now', 'single', 'import'];
  if (!submitTypes.contains(type.value)) {
    throw Exception('Invalid submit type $type');
  }

  List<Map<String, dynamic>> payload;
  if (listen is List<SubmissionListen> && type == SubmissionListenTypes.import) {
    payload = listen.map((l) => l.toJson()).toList();
  } else if (listen is SubmissionListen) {
    payload = [listen.toJson()];
  } else {
    throw ArgumentError('Invalid function call, check arguments.');
  }

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $userToken',
  };

  final reqBody = jsonEncode({
    'listen_type': type.value,
    'payload': payload,
  });

  final response = await rateLimiter.schedule(
    () => httpClient.post(
      Uri.parse(url),
      headers: headers,
      body: reqBody,
    ),
  );

  return response;
}
