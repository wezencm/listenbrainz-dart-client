class ApiUnauthorized implements Exception {
  final int code;
  final String? error;

  ApiUnauthorized(this.code, [this.error]);

  @override
  String toString() => '[ListenBrainz][API ERROR] invalid authorization: $error';
}