// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vw_schd_billing_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VwSchdBillingItem _$VwSchdBillingItemFromJson(Map<String, dynamic> json) =>
    _VwSchdBillingItem(
      dscp: json['Dscp'] as String?,
      id: (json['Id'] as num?)?.toInt(),
      fromDate: (json['FromDate'] as num?)?.toInt(),
      toDate: (json['ToDate'] as num?)?.toInt(),
      schdDay: (json['SchdDay'] as num?)?.toInt(),
      schdRcrsvType: json['SchdRcrsvType'],
      schdRcrsvInterval: (json['SchdRcrsvInterval'] as num?)?.toInt(),
      toTime: (json['ToTime'] as num?)?.toInt(),
      timeRcrsvType: json['TimeRcrsvType'],
      timeRcrsvInterval: (json['TimeRcrsvInterval'] as num?)?.toInt(),
      lastSchd: json['LastSchd'],
      lastRun: json['LastRun'],
      nextRunDate: (json['NextRunDate'] as num?)?.toInt(),
      nextRunTime: (json['NextRunTime'] as num?)?.toInt(),
      bitInd: (json['BitInd'] as num?)?.toInt(),
      sts: json['Sts'],
    );

Map<String, dynamic> _$VwSchdBillingItemToJson(_VwSchdBillingItem instance) =>
    <String, dynamic>{
      'Dscp': instance.dscp,
      'Id': instance.id,
      'FromDate': instance.fromDate,
      'ToDate': instance.toDate,
      'SchdDay': instance.schdDay,
      'SchdRcrsvType': instance.schdRcrsvType,
      'SchdRcrsvInterval': instance.schdRcrsvInterval,
      'ToTime': instance.toTime,
      'TimeRcrsvType': instance.timeRcrsvType,
      'TimeRcrsvInterval': instance.timeRcrsvInterval,
      'LastSchd': instance.lastSchd,
      'LastRun': instance.lastRun,
      'NextRunDate': instance.nextRunDate,
      'NextRunTime': instance.nextRunTime,
      'BitInd': instance.bitInd,
      'Sts': instance.sts,
    };
