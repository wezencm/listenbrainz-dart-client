class ApiException implements Exception {
  final int code;
  final String? error;

  ApiException(this.code, [this.error]);

  @override
  String toString() => '[ListenBrainz][API ERROR] code: $code, error: $error';
}