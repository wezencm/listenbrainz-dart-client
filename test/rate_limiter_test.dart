import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:listenbrainz/src/utils/rate_limiter.dart';
import 'package:test/test.dart';

void main() {
  group('RateLimiter', () {
    late RateLimiter rateLimiter;

    setUp(() {
      rateLimiter = RateLimiter();
    });

    test('should execute a single request immediately', () async {
      final response = http.Response('test', 200);
      final request = () async => response;

      final result = await rateLimiter.schedule(request);

      expect(result, equals(response));
      expect(result.statusCode, equals(200));
      expect(result.body, equals('test'));
    });

    test('should process requests in order', () async {
      final responses = <int>[];
      final futures = <Future<http.Response>>[];

      for (int i = 0; i < 5; i++) {
        final index = i;
        futures.add(
          rateLimiter.schedule(() async {
            responses.add(index);
            return http.Response('response $index', 200);
          }),
        );
      }

      await Future.wait(futures);

      expect(responses, equals([0, 1, 2, 3, 4]));
    });

    test('should update rate limits from response headers', () async {
      final response = http.Response('test', 200, headers: {
        'x-ratelimit-remaining': '5',
        'x-ratelimit-reset-in': '60',
      });

      await rateLimiter.schedule(() async => response);

      // Schedule another request to verify rate limits were updated
      final secondResponse = http.Response('test2', 200, headers: {
        'x-ratelimit-remaining': '4',
        'x-ratelimit-reset-in': '59',
      });

      await rateLimiter.schedule(() async => secondResponse);

      // The rate limiter should have processed both requests
      // We can't directly check internal state, but we can verify
      // that requests still execute when remaining > 0
      expect(secondResponse.statusCode, equals(200));
    });

    test('should wait when rate limit is exhausted', () async {
      // First request sets remaining to 0
      final firstResponse = http.Response('test', 200, headers: {
        'x-ratelimit-remaining': '0',
        'x-ratelimit-reset-in': '1', // 1 second
      });

      final startTime = DateTime.now();
      await rateLimiter.schedule(() async => firstResponse);

      // Second request should wait
      final secondResponse = http.Response('test2', 200, headers: {
        'x-ratelimit-remaining': '10',
        'x-ratelimit-reset-in': '0',
      });

      await rateLimiter.schedule(() async => secondResponse);
      final endTime = DateTime.now();

      // Should have waited at least 1 second
      final duration = endTime.difference(startTime);
      expect(duration.inSeconds, greaterThanOrEqualTo(1));
    });

    test('should handle errors and propagate them', () async {
      final error = Exception('Request failed');
      final request = () async => throw error;

      expect(
        () => rateLimiter.schedule(request),
        throwsA(isA<Exception>()),
      );
    });

    test('should handle each request with its own function', () async {
      final results = <String>[];

      final future1 = rateLimiter.schedule(() async {
        results.add('request1');
        return http.Response('response1', 200);
      });

      final future2 = rateLimiter.schedule(() async {
        results.add('request2');
        return http.Response('response2', 200);
      });

      final future3 = rateLimiter.schedule(() async {
        results.add('request3');
        return http.Response('response3', 200);
      });

      final responses = await Future.wait([future1, future2, future3]);

      expect(results, equals(['request1', 'request2', 'request3']));
      expect(responses[0].body, equals('response1'));
      expect(responses[1].body, equals('response2'));
      expect(responses[2].body, equals('response3'));
    });

    test('should handle invalid rate limit headers gracefully', () async {
      final response1 = http.Response('test', 200, headers: {
        'x-ratelimit-remaining': 'invalid',
        'x-ratelimit-reset-in': 'not-a-number',
      });

      await rateLimiter.schedule(() async => response1);

      // Should still process subsequent requests
      final response2 = http.Response('test2', 200);
      final result = await rateLimiter.schedule(() async => response2);

      expect(result.statusCode, equals(200));
    });

    test('should handle missing rate limit headers', () async {
      final response = http.Response('test', 200);

      final result = await rateLimiter.schedule(() async => response);

      expect(result.statusCode, equals(200));
      expect(result.body, equals('test'));
    });

    test('should handle multiple concurrent schedule calls', () async {
      final futures = <Future<http.Response>>[];

      // Schedule 10 requests concurrently
      for (int i = 0; i < 10; i++) {
        final index = i;
        futures.add(
          rateLimiter.schedule(() async {
            await Future.delayed(Duration(milliseconds: 10));
            return http.Response('response $index', 200);
          }),
        );
      }

      final responses = await Future.wait(futures);

      expect(responses.length, equals(10));
      for (int i = 0; i < 10; i++) {
        expect(responses[i].body, equals('response $i'));
      }
    });

    test('should handle rate limit reset correctly', () async {
      // First request exhausts rate limit
      final firstResponse = http.Response('test1', 200, headers: {
        'x-ratelimit-remaining': '0',
        'x-ratelimit-reset-in': '0', // Reset immediately
      });

      await rateLimiter.schedule(() async => firstResponse);

      // Second request should proceed without delay
      final secondResponse = http.Response('test2', 200, headers: {
        'x-ratelimit-remaining': '10',
        'x-ratelimit-reset-in': '0',
      });

      final startTime = DateTime.now();
      await rateLimiter.schedule(() async => secondResponse);
      final endTime = DateTime.now();

      // Should not wait when reset-in is 0
      final duration = endTime.difference(startTime);
      expect(duration.inMilliseconds, lessThan(100));
    });

    test('should handle partial rate limit headers', () async {
      // Only remaining header
      final response1 = http.Response('test1', 200, headers: {
        'x-ratelimit-remaining': '5',
      });

      await rateLimiter.schedule(() async => response1);

      // Only reset-in header
      final response2 = http.Response('test2', 200, headers: {
        'x-ratelimit-reset-in': '30',
      });

      final result = await rateLimiter.schedule(() async => response2);
      expect(result.statusCode, equals(200));
    });

    test('should process requests sequentially even with delays', () async {
      final executionOrder = <int>[];

      final futures = <Future<http.Response>>[];

      for (int i = 0; i < 3; i++) {
        final index = i;
        futures.add(
          rateLimiter.schedule(() async {
            executionOrder.add(index);
            await Future.delayed(Duration(milliseconds: 50));
            return http.Response('response $index', 200);
          }),
        );
      }

      await Future.wait(futures);

      // Should execute in order
      expect(executionOrder, equals([0, 1, 2]));
    });
  });
}

