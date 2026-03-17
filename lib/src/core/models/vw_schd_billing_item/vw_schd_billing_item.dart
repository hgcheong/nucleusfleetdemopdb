// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'vw_schd_billing_item.freezed.dart';
part 'vw_schd_billing_item.g.dart';

@freezed
abstract class VwSchdBillingItem with _$VwSchdBillingItem {
  factory VwSchdBillingItem({
    @JsonKey(name: 'Dscp') String? dscp,
    @JsonKey(name: 'Id') int? id,
    @JsonKey(name: 'FromDate') int? fromDate,
    @JsonKey(name: 'ToDate') int? toDate,
    @JsonKey(name: 'SchdDay') int? schdDay,
    @JsonKey(name: 'SchdRcrsvType') dynamic schdRcrsvType,
    @JsonKey(name: 'SchdRcrsvInterval') int? schdRcrsvInterval,
    @JsonKey(name: 'ToTime') int? toTime,
    @JsonKey(name: 'TimeRcrsvType') dynamic timeRcrsvType,
    @JsonKey(name: 'TimeRcrsvInterval') int? timeRcrsvInterval,
    @JsonKey(name: 'LastSchd') dynamic lastSchd,
    @JsonKey(name: 'LastRun') dynamic lastRun,
    @JsonKey(name: 'NextRunDate') int? nextRunDate,
    @JsonKey(name: 'NextRunTime') int? nextRunTime,
    @JsonKey(name: 'BitInd') int? bitInd,
    @JsonKey(name: 'Sts') dynamic sts,
  }) = _VwSchdBillingItem;

  factory VwSchdBillingItem.fromJson(Map<String, dynamic> json) =>
      _$VwSchdBillingItemFromJson(json);

  static List<VwSchdBillingItem> fromJsonList(List list) {
    return list.map((item) => VwSchdBillingItem.fromJson(item)).toList();
  }
}
