// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vw_schd_billing_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VwSchdBillingItem {
  @JsonKey(name: 'Dscp')
  String? get dscp;
  @JsonKey(name: 'Id')
  int? get id;
  @JsonKey(name: 'FromDate')
  int? get fromDate;
  @JsonKey(name: 'ToDate')
  int? get toDate;
  @JsonKey(name: 'SchdDay')
  int? get schdDay;
  @JsonKey(name: 'SchdRcrsvType')
  dynamic get schdRcrsvType;
  @JsonKey(name: 'SchdRcrsvInterval')
  int? get schdRcrsvInterval;
  @JsonKey(name: 'ToTime')
  int? get toTime;
  @JsonKey(name: 'TimeRcrsvType')
  dynamic get timeRcrsvType;
  @JsonKey(name: 'TimeRcrsvInterval')
  int? get timeRcrsvInterval;
  @JsonKey(name: 'LastSchd')
  dynamic get lastSchd;
  @JsonKey(name: 'LastRun')
  dynamic get lastRun;
  @JsonKey(name: 'NextRunDate')
  int? get nextRunDate;
  @JsonKey(name: 'NextRunTime')
  int? get nextRunTime;
  @JsonKey(name: 'BitInd')
  int? get bitInd;
  @JsonKey(name: 'Sts')
  dynamic get sts;

  /// Create a copy of VwSchdBillingItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VwSchdBillingItemCopyWith<VwSchdBillingItem> get copyWith =>
      _$VwSchdBillingItemCopyWithImpl<VwSchdBillingItem>(
          this as VwSchdBillingItem, _$identity);

  /// Serializes this VwSchdBillingItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VwSchdBillingItem &&
            (identical(other.dscp, dscp) || other.dscp == dscp) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            (identical(other.schdDay, schdDay) || other.schdDay == schdDay) &&
            const DeepCollectionEquality()
                .equals(other.schdRcrsvType, schdRcrsvType) &&
            (identical(other.schdRcrsvInterval, schdRcrsvInterval) ||
                other.schdRcrsvInterval == schdRcrsvInterval) &&
            (identical(other.toTime, toTime) || other.toTime == toTime) &&
            const DeepCollectionEquality()
                .equals(other.timeRcrsvType, timeRcrsvType) &&
            (identical(other.timeRcrsvInterval, timeRcrsvInterval) ||
                other.timeRcrsvInterval == timeRcrsvInterval) &&
            const DeepCollectionEquality().equals(other.lastSchd, lastSchd) &&
            const DeepCollectionEquality().equals(other.lastRun, lastRun) &&
            (identical(other.nextRunDate, nextRunDate) ||
                other.nextRunDate == nextRunDate) &&
            (identical(other.nextRunTime, nextRunTime) ||
                other.nextRunTime == nextRunTime) &&
            (identical(other.bitInd, bitInd) || other.bitInd == bitInd) &&
            const DeepCollectionEquality().equals(other.sts, sts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      dscp,
      id,
      fromDate,
      toDate,
      schdDay,
      const DeepCollectionEquality().hash(schdRcrsvType),
      schdRcrsvInterval,
      toTime,
      const DeepCollectionEquality().hash(timeRcrsvType),
      timeRcrsvInterval,
      const DeepCollectionEquality().hash(lastSchd),
      const DeepCollectionEquality().hash(lastRun),
      nextRunDate,
      nextRunTime,
      bitInd,
      const DeepCollectionEquality().hash(sts));

  @override
  String toString() {
    return 'VwSchdBillingItem(dscp: $dscp, id: $id, fromDate: $fromDate, toDate: $toDate, schdDay: $schdDay, schdRcrsvType: $schdRcrsvType, schdRcrsvInterval: $schdRcrsvInterval, toTime: $toTime, timeRcrsvType: $timeRcrsvType, timeRcrsvInterval: $timeRcrsvInterval, lastSchd: $lastSchd, lastRun: $lastRun, nextRunDate: $nextRunDate, nextRunTime: $nextRunTime, bitInd: $bitInd, sts: $sts)';
  }
}

/// @nodoc
abstract mixin class $VwSchdBillingItemCopyWith<$Res> {
  factory $VwSchdBillingItemCopyWith(
          VwSchdBillingItem value, $Res Function(VwSchdBillingItem) _then) =
      _$VwSchdBillingItemCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'Dscp') String? dscp,
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
      @JsonKey(name: 'Sts') dynamic sts});
}

/// @nodoc
class _$VwSchdBillingItemCopyWithImpl<$Res>
    implements $VwSchdBillingItemCopyWith<$Res> {
  _$VwSchdBillingItemCopyWithImpl(this._self, this._then);

  final VwSchdBillingItem _self;
  final $Res Function(VwSchdBillingItem) _then;

  /// Create a copy of VwSchdBillingItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dscp = freezed,
    Object? id = freezed,
    Object? fromDate = freezed,
    Object? toDate = freezed,
    Object? schdDay = freezed,
    Object? schdRcrsvType = freezed,
    Object? schdRcrsvInterval = freezed,
    Object? toTime = freezed,
    Object? timeRcrsvType = freezed,
    Object? timeRcrsvInterval = freezed,
    Object? lastSchd = freezed,
    Object? lastRun = freezed,
    Object? nextRunDate = freezed,
    Object? nextRunTime = freezed,
    Object? bitInd = freezed,
    Object? sts = freezed,
  }) {
    return _then(_self.copyWith(
      dscp: freezed == dscp
          ? _self.dscp
          : dscp // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      fromDate: freezed == fromDate
          ? _self.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as int?,
      toDate: freezed == toDate
          ? _self.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as int?,
      schdDay: freezed == schdDay
          ? _self.schdDay
          : schdDay // ignore: cast_nullable_to_non_nullable
              as int?,
      schdRcrsvType: freezed == schdRcrsvType
          ? _self.schdRcrsvType
          : schdRcrsvType // ignore: cast_nullable_to_non_nullable
              as dynamic,
      schdRcrsvInterval: freezed == schdRcrsvInterval
          ? _self.schdRcrsvInterval
          : schdRcrsvInterval // ignore: cast_nullable_to_non_nullable
              as int?,
      toTime: freezed == toTime
          ? _self.toTime
          : toTime // ignore: cast_nullable_to_non_nullable
              as int?,
      timeRcrsvType: freezed == timeRcrsvType
          ? _self.timeRcrsvType
          : timeRcrsvType // ignore: cast_nullable_to_non_nullable
              as dynamic,
      timeRcrsvInterval: freezed == timeRcrsvInterval
          ? _self.timeRcrsvInterval
          : timeRcrsvInterval // ignore: cast_nullable_to_non_nullable
              as int?,
      lastSchd: freezed == lastSchd
          ? _self.lastSchd
          : lastSchd // ignore: cast_nullable_to_non_nullable
              as dynamic,
      lastRun: freezed == lastRun
          ? _self.lastRun
          : lastRun // ignore: cast_nullable_to_non_nullable
              as dynamic,
      nextRunDate: freezed == nextRunDate
          ? _self.nextRunDate
          : nextRunDate // ignore: cast_nullable_to_non_nullable
              as int?,
      nextRunTime: freezed == nextRunTime
          ? _self.nextRunTime
          : nextRunTime // ignore: cast_nullable_to_non_nullable
              as int?,
      bitInd: freezed == bitInd
          ? _self.bitInd
          : bitInd // ignore: cast_nullable_to_non_nullable
              as int?,
      sts: freezed == sts
          ? _self.sts
          : sts // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _VwSchdBillingItem implements VwSchdBillingItem {
  _VwSchdBillingItem(
      {@JsonKey(name: 'Dscp') this.dscp,
      @JsonKey(name: 'Id') this.id,
      @JsonKey(name: 'FromDate') this.fromDate,
      @JsonKey(name: 'ToDate') this.toDate,
      @JsonKey(name: 'SchdDay') this.schdDay,
      @JsonKey(name: 'SchdRcrsvType') this.schdRcrsvType,
      @JsonKey(name: 'SchdRcrsvInterval') this.schdRcrsvInterval,
      @JsonKey(name: 'ToTime') this.toTime,
      @JsonKey(name: 'TimeRcrsvType') this.timeRcrsvType,
      @JsonKey(name: 'TimeRcrsvInterval') this.timeRcrsvInterval,
      @JsonKey(name: 'LastSchd') this.lastSchd,
      @JsonKey(name: 'LastRun') this.lastRun,
      @JsonKey(name: 'NextRunDate') this.nextRunDate,
      @JsonKey(name: 'NextRunTime') this.nextRunTime,
      @JsonKey(name: 'BitInd') this.bitInd,
      @JsonKey(name: 'Sts') this.sts});
  factory _VwSchdBillingItem.fromJson(Map<String, dynamic> json) =>
      _$VwSchdBillingItemFromJson(json);

  @override
  @JsonKey(name: 'Dscp')
  final String? dscp;
  @override
  @JsonKey(name: 'Id')
  final int? id;
  @override
  @JsonKey(name: 'FromDate')
  final int? fromDate;
  @override
  @JsonKey(name: 'ToDate')
  final int? toDate;
  @override
  @JsonKey(name: 'SchdDay')
  final int? schdDay;
  @override
  @JsonKey(name: 'SchdRcrsvType')
  final dynamic schdRcrsvType;
  @override
  @JsonKey(name: 'SchdRcrsvInterval')
  final int? schdRcrsvInterval;
  @override
  @JsonKey(name: 'ToTime')
  final int? toTime;
  @override
  @JsonKey(name: 'TimeRcrsvType')
  final dynamic timeRcrsvType;
  @override
  @JsonKey(name: 'TimeRcrsvInterval')
  final int? timeRcrsvInterval;
  @override
  @JsonKey(name: 'LastSchd')
  final dynamic lastSchd;
  @override
  @JsonKey(name: 'LastRun')
  final dynamic lastRun;
  @override
  @JsonKey(name: 'NextRunDate')
  final int? nextRunDate;
  @override
  @JsonKey(name: 'NextRunTime')
  final int? nextRunTime;
  @override
  @JsonKey(name: 'BitInd')
  final int? bitInd;
  @override
  @JsonKey(name: 'Sts')
  final dynamic sts;

  /// Create a copy of VwSchdBillingItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VwSchdBillingItemCopyWith<_VwSchdBillingItem> get copyWith =>
      __$VwSchdBillingItemCopyWithImpl<_VwSchdBillingItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VwSchdBillingItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VwSchdBillingItem &&
            (identical(other.dscp, dscp) || other.dscp == dscp) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            (identical(other.schdDay, schdDay) || other.schdDay == schdDay) &&
            const DeepCollectionEquality()
                .equals(other.schdRcrsvType, schdRcrsvType) &&
            (identical(other.schdRcrsvInterval, schdRcrsvInterval) ||
                other.schdRcrsvInterval == schdRcrsvInterval) &&
            (identical(other.toTime, toTime) || other.toTime == toTime) &&
            const DeepCollectionEquality()
                .equals(other.timeRcrsvType, timeRcrsvType) &&
            (identical(other.timeRcrsvInterval, timeRcrsvInterval) ||
                other.timeRcrsvInterval == timeRcrsvInterval) &&
            const DeepCollectionEquality().equals(other.lastSchd, lastSchd) &&
            const DeepCollectionEquality().equals(other.lastRun, lastRun) &&
            (identical(other.nextRunDate, nextRunDate) ||
                other.nextRunDate == nextRunDate) &&
            (identical(other.nextRunTime, nextRunTime) ||
                other.nextRunTime == nextRunTime) &&
            (identical(other.bitInd, bitInd) || other.bitInd == bitInd) &&
            const DeepCollectionEquality().equals(other.sts, sts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      dscp,
      id,
      fromDate,
      toDate,
      schdDay,
      const DeepCollectionEquality().hash(schdRcrsvType),
      schdRcrsvInterval,
      toTime,
      const DeepCollectionEquality().hash(timeRcrsvType),
      timeRcrsvInterval,
      const DeepCollectionEquality().hash(lastSchd),
      const DeepCollectionEquality().hash(lastRun),
      nextRunDate,
      nextRunTime,
      bitInd,
      const DeepCollectionEquality().hash(sts));

  @override
  String toString() {
    return 'VwSchdBillingItem(dscp: $dscp, id: $id, fromDate: $fromDate, toDate: $toDate, schdDay: $schdDay, schdRcrsvType: $schdRcrsvType, schdRcrsvInterval: $schdRcrsvInterval, toTime: $toTime, timeRcrsvType: $timeRcrsvType, timeRcrsvInterval: $timeRcrsvInterval, lastSchd: $lastSchd, lastRun: $lastRun, nextRunDate: $nextRunDate, nextRunTime: $nextRunTime, bitInd: $bitInd, sts: $sts)';
  }
}

/// @nodoc
abstract mixin class _$VwSchdBillingItemCopyWith<$Res>
    implements $VwSchdBillingItemCopyWith<$Res> {
  factory _$VwSchdBillingItemCopyWith(
          _VwSchdBillingItem value, $Res Function(_VwSchdBillingItem) _then) =
      __$VwSchdBillingItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Dscp') String? dscp,
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
      @JsonKey(name: 'Sts') dynamic sts});
}

/// @nodoc
class __$VwSchdBillingItemCopyWithImpl<$Res>
    implements _$VwSchdBillingItemCopyWith<$Res> {
  __$VwSchdBillingItemCopyWithImpl(this._self, this._then);

  final _VwSchdBillingItem _self;
  final $Res Function(_VwSchdBillingItem) _then;

  /// Create a copy of VwSchdBillingItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? dscp = freezed,
    Object? id = freezed,
    Object? fromDate = freezed,
    Object? toDate = freezed,
    Object? schdDay = freezed,
    Object? schdRcrsvType = freezed,
    Object? schdRcrsvInterval = freezed,
    Object? toTime = freezed,
    Object? timeRcrsvType = freezed,
    Object? timeRcrsvInterval = freezed,
    Object? lastSchd = freezed,
    Object? lastRun = freezed,
    Object? nextRunDate = freezed,
    Object? nextRunTime = freezed,
    Object? bitInd = freezed,
    Object? sts = freezed,
  }) {
    return _then(_VwSchdBillingItem(
      dscp: freezed == dscp
          ? _self.dscp
          : dscp // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      fromDate: freezed == fromDate
          ? _self.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as int?,
      toDate: freezed == toDate
          ? _self.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as int?,
      schdDay: freezed == schdDay
          ? _self.schdDay
          : schdDay // ignore: cast_nullable_to_non_nullable
              as int?,
      schdRcrsvType: freezed == schdRcrsvType
          ? _self.schdRcrsvType
          : schdRcrsvType // ignore: cast_nullable_to_non_nullable
              as dynamic,
      schdRcrsvInterval: freezed == schdRcrsvInterval
          ? _self.schdRcrsvInterval
          : schdRcrsvInterval // ignore: cast_nullable_to_non_nullable
              as int?,
      toTime: freezed == toTime
          ? _self.toTime
          : toTime // ignore: cast_nullable_to_non_nullable
              as int?,
      timeRcrsvType: freezed == timeRcrsvType
          ? _self.timeRcrsvType
          : timeRcrsvType // ignore: cast_nullable_to_non_nullable
              as dynamic,
      timeRcrsvInterval: freezed == timeRcrsvInterval
          ? _self.timeRcrsvInterval
          : timeRcrsvInterval // ignore: cast_nullable_to_non_nullable
              as int?,
      lastSchd: freezed == lastSchd
          ? _self.lastSchd
          : lastSchd // ignore: cast_nullable_to_non_nullable
              as dynamic,
      lastRun: freezed == lastRun
          ? _self.lastRun
          : lastRun // ignore: cast_nullable_to_non_nullable
              as dynamic,
      nextRunDate: freezed == nextRunDate
          ? _self.nextRunDate
          : nextRunDate // ignore: cast_nullable_to_non_nullable
              as int?,
      nextRunTime: freezed == nextRunTime
          ? _self.nextRunTime
          : nextRunTime // ignore: cast_nullable_to_non_nullable
              as int?,
      bitInd: freezed == bitInd
          ? _self.bitInd
          : bitInd // ignore: cast_nullable_to_non_nullable
              as int?,
      sts: freezed == sts
          ? _self.sts
          : sts // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

// dart format on
