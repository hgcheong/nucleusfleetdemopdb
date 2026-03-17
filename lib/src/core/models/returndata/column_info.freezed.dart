// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'column_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ColumnInfo {
  String? get title;
  String? get data;
  String? get dataType;
  bool? get visible;
  bool? get isReq;

  /// Create a copy of ColumnInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ColumnInfoCopyWith<ColumnInfo> get copyWith =>
      _$ColumnInfoCopyWithImpl<ColumnInfo>(this as ColumnInfo, _$identity);

  /// Serializes this ColumnInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ColumnInfo &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.dataType, dataType) ||
                other.dataType == dataType) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.isReq, isReq) || other.isReq == isReq));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, data, dataType, visible, isReq);

  @override
  String toString() {
    return 'ColumnInfo(title: $title, data: $data, dataType: $dataType, visible: $visible, isReq: $isReq)';
  }
}

/// @nodoc
abstract mixin class $ColumnInfoCopyWith<$Res> {
  factory $ColumnInfoCopyWith(
          ColumnInfo value, $Res Function(ColumnInfo) _then) =
      _$ColumnInfoCopyWithImpl;
  @useResult
  $Res call(
      {String? title,
      String? data,
      String? dataType,
      bool? visible,
      bool? isReq});
}

/// @nodoc
class _$ColumnInfoCopyWithImpl<$Res> implements $ColumnInfoCopyWith<$Res> {
  _$ColumnInfoCopyWithImpl(this._self, this._then);

  final ColumnInfo _self;
  final $Res Function(ColumnInfo) _then;

  /// Create a copy of ColumnInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? data = freezed,
    Object? dataType = freezed,
    Object? visible = freezed,
    Object? isReq = freezed,
  }) {
    return _then(_self.copyWith(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
      dataType: freezed == dataType
          ? _self.dataType
          : dataType // ignore: cast_nullable_to_non_nullable
              as String?,
      visible: freezed == visible
          ? _self.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool?,
      isReq: freezed == isReq
          ? _self.isReq
          : isReq // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ColumnInfo implements ColumnInfo {
  _ColumnInfo({this.title, this.data, this.dataType, this.visible, this.isReq});
  factory _ColumnInfo.fromJson(Map<String, dynamic> json) =>
      _$ColumnInfoFromJson(json);

  @override
  final String? title;
  @override
  final String? data;
  @override
  final String? dataType;
  @override
  final bool? visible;
  @override
  final bool? isReq;

  /// Create a copy of ColumnInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ColumnInfoCopyWith<_ColumnInfo> get copyWith =>
      __$ColumnInfoCopyWithImpl<_ColumnInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ColumnInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ColumnInfo &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.dataType, dataType) ||
                other.dataType == dataType) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.isReq, isReq) || other.isReq == isReq));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, data, dataType, visible, isReq);

  @override
  String toString() {
    return 'ColumnInfo(title: $title, data: $data, dataType: $dataType, visible: $visible, isReq: $isReq)';
  }
}

/// @nodoc
abstract mixin class _$ColumnInfoCopyWith<$Res>
    implements $ColumnInfoCopyWith<$Res> {
  factory _$ColumnInfoCopyWith(
          _ColumnInfo value, $Res Function(_ColumnInfo) _then) =
      __$ColumnInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? title,
      String? data,
      String? dataType,
      bool? visible,
      bool? isReq});
}

/// @nodoc
class __$ColumnInfoCopyWithImpl<$Res> implements _$ColumnInfoCopyWith<$Res> {
  __$ColumnInfoCopyWithImpl(this._self, this._then);

  final _ColumnInfo _self;
  final $Res Function(_ColumnInfo) _then;

  /// Create a copy of ColumnInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = freezed,
    Object? data = freezed,
    Object? dataType = freezed,
    Object? visible = freezed,
    Object? isReq = freezed,
  }) {
    return _then(_ColumnInfo(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
      dataType: freezed == dataType
          ? _self.dataType
          : dataType // ignore: cast_nullable_to_non_nullable
              as String?,
      visible: freezed == visible
          ? _self.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool?,
      isReq: freezed == isReq
          ? _self.isReq
          : isReq // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

// dart format on
