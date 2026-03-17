// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'returndata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Returndata {
  List<dynamic>? get data;
  List<Output>? get output;
  int? get rowcount;
  List<ColumnInfo>? get columnInfo;
  Message? get message;
  dynamic get error;

  /// Create a copy of Returndata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReturndataCopyWith<Returndata> get copyWith =>
      _$ReturndataCopyWithImpl<Returndata>(this as Returndata, _$identity);

  /// Serializes this Returndata to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Returndata &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.output, output) &&
            (identical(other.rowcount, rowcount) ||
                other.rowcount == rowcount) &&
            const DeepCollectionEquality()
                .equals(other.columnInfo, columnInfo) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(output),
      rowcount,
      const DeepCollectionEquality().hash(columnInfo),
      message,
      const DeepCollectionEquality().hash(error));

  @override
  String toString() {
    return 'Returndata(data: $data, output: $output, rowcount: $rowcount, columnInfo: $columnInfo, message: $message, error: $error)';
  }
}

/// @nodoc
abstract mixin class $ReturndataCopyWith<$Res> {
  factory $ReturndataCopyWith(
          Returndata value, $Res Function(Returndata) _then) =
      _$ReturndataCopyWithImpl;
  @useResult
  $Res call(
      {List<dynamic>? data,
      List<Output>? output,
      int? rowcount,
      List<ColumnInfo>? columnInfo,
      Message? message,
      dynamic error});

  $MessageCopyWith<$Res>? get message;
}

/// @nodoc
class _$ReturndataCopyWithImpl<$Res> implements $ReturndataCopyWith<$Res> {
  _$ReturndataCopyWithImpl(this._self, this._then);

  final Returndata _self;
  final $Res Function(Returndata) _then;

  /// Create a copy of Returndata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? output = freezed,
    Object? rowcount = freezed,
    Object? columnInfo = freezed,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_self.copyWith(
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      output: freezed == output
          ? _self.output
          : output // ignore: cast_nullable_to_non_nullable
              as List<Output>?,
      rowcount: freezed == rowcount
          ? _self.rowcount
          : rowcount // ignore: cast_nullable_to_non_nullable
              as int?,
      columnInfo: freezed == columnInfo
          ? _self.columnInfo
          : columnInfo // ignore: cast_nullable_to_non_nullable
              as List<ColumnInfo>?,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }

  /// Create a copy of Returndata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageCopyWith<$Res>? get message {
    if (_self.message == null) {
      return null;
    }

    return $MessageCopyWith<$Res>(_self.message!, (value) {
      return _then(_self.copyWith(message: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _Returndata implements Returndata {
  _Returndata(
      {final List<dynamic>? data,
      final List<Output>? output,
      this.rowcount,
      final List<ColumnInfo>? columnInfo,
      this.message,
      this.error})
      : _data = data,
        _output = output,
        _columnInfo = columnInfo;
  factory _Returndata.fromJson(Map<String, dynamic> json) =>
      _$ReturndataFromJson(json);

  final List<dynamic>? _data;
  @override
  List<dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Output>? _output;
  @override
  List<Output>? get output {
    final value = _output;
    if (value == null) return null;
    if (_output is EqualUnmodifiableListView) return _output;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? rowcount;
  final List<ColumnInfo>? _columnInfo;
  @override
  List<ColumnInfo>? get columnInfo {
    final value = _columnInfo;
    if (value == null) return null;
    if (_columnInfo is EqualUnmodifiableListView) return _columnInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Message? message;
  @override
  final dynamic error;

  /// Create a copy of Returndata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReturndataCopyWith<_Returndata> get copyWith =>
      __$ReturndataCopyWithImpl<_Returndata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReturndataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Returndata &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality().equals(other._output, _output) &&
            (identical(other.rowcount, rowcount) ||
                other.rowcount == rowcount) &&
            const DeepCollectionEquality()
                .equals(other._columnInfo, _columnInfo) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_output),
      rowcount,
      const DeepCollectionEquality().hash(_columnInfo),
      message,
      const DeepCollectionEquality().hash(error));

  @override
  String toString() {
    return 'Returndata(data: $data, output: $output, rowcount: $rowcount, columnInfo: $columnInfo, message: $message, error: $error)';
  }
}

/// @nodoc
abstract mixin class _$ReturndataCopyWith<$Res>
    implements $ReturndataCopyWith<$Res> {
  factory _$ReturndataCopyWith(
          _Returndata value, $Res Function(_Returndata) _then) =
      __$ReturndataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<dynamic>? data,
      List<Output>? output,
      int? rowcount,
      List<ColumnInfo>? columnInfo,
      Message? message,
      dynamic error});

  @override
  $MessageCopyWith<$Res>? get message;
}

/// @nodoc
class __$ReturndataCopyWithImpl<$Res> implements _$ReturndataCopyWith<$Res> {
  __$ReturndataCopyWithImpl(this._self, this._then);

  final _Returndata _self;
  final $Res Function(_Returndata) _then;

  /// Create a copy of Returndata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = freezed,
    Object? output = freezed,
    Object? rowcount = freezed,
    Object? columnInfo = freezed,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_Returndata(
      data: freezed == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      output: freezed == output
          ? _self._output
          : output // ignore: cast_nullable_to_non_nullable
              as List<Output>?,
      rowcount: freezed == rowcount
          ? _self.rowcount
          : rowcount // ignore: cast_nullable_to_non_nullable
              as int?,
      columnInfo: freezed == columnInfo
          ? _self._columnInfo
          : columnInfo // ignore: cast_nullable_to_non_nullable
              as List<ColumnInfo>?,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }

  /// Create a copy of Returndata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageCopyWith<$Res>? get message {
    if (_self.message == null) {
      return null;
    }

    return $MessageCopyWith<$Res>(_self.message!, (value) {
      return _then(_self.copyWith(message: value));
    });
  }
}

// dart format on
