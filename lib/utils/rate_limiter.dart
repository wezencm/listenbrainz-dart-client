import 'dart:async';
import 'dart:collection';
import 'package:http/http.dart' as http;

/// Advanced: HTTP rate limiter used internally by [ListenBrainz].
///
/// You usually don't need to construct this yourself; a default instance is
/// created per [ListenBrainz] client. If you're creating multiple
/// [ListenBrainz] instances (e.g. per user) you  will need to share the rate limiter
/// otherwise, one ListenBrainz instance will not know when other hit the rate limit.
/// So, you just create a single [RateLimiter] and pass it via `InitParams`.
class RateLimiter {
  final Queue<_QueuedRequest> _queue = Queue();
  bool _isProcessing = false;

  int _remaining = 9999; // until first response
  Duration _resetIn = Duration.zero;

  Future<http.Response> schedule(Future<http.Response> Function() request) {
    final completer = Completer<http.Response>();
    _queue.add(_QueuedRequest(completer: completer, request: request));

    _processQueue();
    return completer.future;
  }

  void _processQueue() async {
    if (_isProcessing) return;
    _isProcessing = true;

    while (_queue.isNotEmpty) {
      if (_remaining <= 0) {
        // wait until reset window
        await Future.delayed(_resetIn);
        _remaining = 9999;
      }

      final queuedRequest = _queue.removeFirst();
      try {
        final response = await queuedRequest.request();
        _updateRateLimits(response);
        queuedRequest.completer.complete(response);
      } catch (e, st) {
        queuedRequest.completer.completeError(e, st);
      }
    }

    _isProcessing = false;
  }

  void _updateRateLimits(http.Response response) {
    final remainingHeader = response.headers['x-ratelimit-remaining'];
    final resetInHeader = response.headers['x-ratelimit-reset-in'];

    if (remainingHeader != null) {
      _remaining = int.tryParse(remainingHeader) ?? _remaining;
    }
    if (resetInHeader != null) {
      final seconds = int.tryParse(resetInHeader) ?? 0;
      _resetIn = Duration(seconds: seconds);
    }
  }
}

class _QueuedRequest {
  final Completer<http.Response> completer;
  final Future<http.Response> Function() request;

  _QueuedRequest({
    required this.completer,
    required this.request,
  });
}
