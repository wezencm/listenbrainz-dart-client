// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_listeners.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatsListeners _$StatsListenersFromJson(Map<String, dynamic> json) =>
    StatsListeners(
      listenCount: (json['listen_count'] as num).toInt(),
      userName: json['user_name'] as String,
    );

Map<String, dynamic> _$StatsListenersToJson(StatsListeners instance) =>
    <String, dynamic>{
      'listen_count': instance.listenCount,
      'user_name': instance.userName,
    };
