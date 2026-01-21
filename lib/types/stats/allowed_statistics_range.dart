import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum AllowedStatisticsRange {
  thisWeek("this_week"),
  thisMonth("this_month"),
  thisYear("this_year"),
  week("week"),
  month("month"),
  quarter("quarter"),
  year("year"),
  halfYearly("half_yearly"),
  allTime("all_time");

  final String value;

  const AllowedStatisticsRange(this.value);
}