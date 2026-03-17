// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'output.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Output {
  String? get parameter;
  dynamic get value;

  /// Create a copy of Output
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OutputCopyWith<Output> get copyWith =>
      _$OutputCopyWithImpl<Output>(this as Output, _$identity);

  /// Serializes this Output to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Output &&
            (identical(other.parameter, parameter) ||
                other.parameter == parameter) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, parameter, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'Output(parameter: $parameter, value: $value)';
  }
}

/// @nodoc
abstract mixin class $OutputCopyWith<$Res> {
  factory $OutputCopyWith(Output value, $Res Function(Output) _then) =
      _$OutputCopyWithImpl;
  @useResult
  $Res call({String? parameter, dynamic value});
}

/// @nodoc
class _$OutputCopyWithImpl<$Res> implements $OutputCopyWith<$Res> {
  _$OutputCopyWithImpl(this._self, this._then);

  final Output _self;
  final $Res Function(Output) _then;

  /// Create a copy of Output
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parameter = freezed,
    Object? value = freezed,
  }) {
    return _then(_self.copyWith(
      parameter: freezed == parameter
          ? _self.parameter
          : parameter // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Output implements Output {
  _Output({this.parameter, this.value});
  factory _Output.fromJson(Map<String, dynamic> json) => _$OutputFromJson(json);

  @override
  final String? parameter;
  @override
  final dynamic value;

  /// Create a copy of Output
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OutputCopyWith<_Output> get copyWith =>
      __$OutputCopyWithImpl<_Output>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OutputToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Output &&
            (identical(other.parameter, parameter) ||
                other.parameter == parameter) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, parameter, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'Output(parameter: $parameter, value: $value)';
  }
}

/// @nodoc
abstract mixin class _$OutputCopyWith<$Res> implements $OutputCopyWith<$Res> {
  factory _$OutputCopyWith(_Output value, $Res Function(_Output) _then) =
      __$OutputCopyWithImpl;
  @override
  @useResult
  $Res call({String? parameter, dynamic value});
}

/// @nodoc
class __$OutputCopyWithImpl<$Res> implements _$OutputCopyWith<$Res> {
  __$OutputCopyWithImpl(this._self, this._then);

  final _Output _self;
  final $Res Function(_Output) _then;

  /// Create a copy of Output
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? parameter = freezed,
    Object? value = freezed,
  }) {
    return _then(_Output(
      parameter: freezed == parameter
          ? _self.parameter
          : parameter // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

// dart format on
