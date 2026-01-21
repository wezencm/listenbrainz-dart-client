import 'package:listenbrainz/components/stats/stats.dart';
import 'package:listenbrainz/src/constants/listenbrainz.dart';
import 'package:listenbrainz/src/response_handler.dart';
import 'package:listenbrainz/src/utils/request_helpers.dart';
import 'package:listenbrainz/types/stats/allowed_statistics_range.dart';

Future<T?> fetchStats<T>({
  required Stats statsInstance,
  required String endpoint,
  required T Function(Map<String, dynamic>) fromJson,
  int? count,
  int? offset,
  AllowedStatisticsRange? range,
}) async {
  if (count != null && count > ListenBrainzConstants.MAX_ITEMS_PER_GET) {
    throw RangeError.value(count);
  }

  final params = <Map<String, dynamic>>[];
  if (count != null) params.add({"count": count});
  if (offset != null) params.add({"offset": offset});
  if (range != null) params.add({"range": range.value});

  final response = await getFromLb(
    listenbrainzURL: statsInstance.params.listenBrainzServerUrl,
    endpoint: endpoint,
    httpClient: statsInstance.client,
    rateLimiter: statsInstance.limiter,
    params: params.isEmpty ? null : params,
  );

  final results = ResponseHandler.handleResponse(response, (decoded) {
    return ResponseHandler.extractPayload(decoded);
  });

  return fromJson(results);
}
