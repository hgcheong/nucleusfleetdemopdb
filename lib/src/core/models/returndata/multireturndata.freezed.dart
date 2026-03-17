// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'multireturndata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MultiReturndata {
  List<Returndata>? get multidata;

  /// Create a copy of MultiReturndata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MultiReturndataCopyWith<MultiReturndata> get copyWith =>
      _$MultiReturndataCopyWithImpl<MultiReturndata>(
          this as MultiReturndata, _$identity);

  /// Serializes this MultiReturndata to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MultiReturndata &&
            const DeepCollectionEquality().equals(other.multidata, multidata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(multidata));

  @override
  String toString() {
    return 'MultiReturndata(multidata: $multidata)';
  }
}

/// @nodoc
abstract mixin class $MultiReturndataCopyWith<$Res> {
  factory $MultiReturndataCopyWith(
          MultiReturndata value, $Res Function(MultiReturndata) _then) =
      _$MultiReturndataCopyWithImpl;
  @useResult
  $Res call({List<Returndata>? multidata});
}

/// @nodoc
class _$MultiReturndataCopyWithImpl<$Res>
    implements $MultiReturndataCopyWith<$Res> {
  _$MultiReturndataCopyWithImpl(this._self, this._then);

  final MultiReturndata _self;
  final $Res Function(MultiReturndata) _then;

  /// Create a copy of MultiReturndata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? multidata = freezed,
  }) {
    return _then(_self.copyWith(
      multidata: freezed == multidata
          ? _self.multidata
          : multidata // ignore: cast_nullable_to_non_nullable
              as List<Returndata>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _MultiReturndata implements MultiReturndata {
  _MultiReturndata({final List<Returndata>? multidata})
      : _multidata = multidata;
  factory _MultiReturndata.fromJson(Map<String, dynamic> json) =>
      _$MultiReturndataFromJson(json);

  final List<Returndata>? _multidata;
  @override
  List<Returndata>? get multidata {
    final value = _multidata;
    if (value == null) return null;
    if (_multidata is EqualUnmodifiableListView) return _multidata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of MultiReturndata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MultiReturndataCopyWith<_MultiReturndata> get copyWith =>
      __$MultiReturndataCopyWithImpl<_MultiReturndata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MultiReturndataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MultiReturndata &&
            const DeepCollectionEquality()
                .equals(other._multidata, _multidata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_multidata));

  @override
  String toString() {
    return 'MultiReturndata(multidata: $multidata)';
  }
}

/// @nodoc
abstract mixin class _$MultiReturndataCopyWith<$Res>
    implements $MultiReturndataCopyWith<$Res> {
  factory _$MultiReturndataCopyWith(
          _MultiReturndata value, $Res Function(_MultiReturndata) _then) =
      __$MultiReturndataCopyWithImpl;
  @override
  @useResult
  $Res call({List<Returndata>? multidata});
}

/// @nodoc
class __$MultiReturndataCopyWithImpl<$Res>
    implements _$MultiReturndataCopyWith<$Res> {
  __$MultiReturndataCopyWithImpl(this._self, this._then);

  final _MultiReturndata _self;
  final $Res Function(_MultiReturndata) _then;

  /// Create a copy of MultiReturndata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? multidata = freezed,
  }) {
    return _then(_MultiReturndata(
      multidata: freezed == multidata
          ? _self._multidata
          : multidata // ignore: cast_nullable_to_non_nullable
              as List<Returndata>?,
    ));
  }
}

// dart format on
