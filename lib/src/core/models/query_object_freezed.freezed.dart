// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_object_freezed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QueryObject {
  String get querysql;
  Map<String, dynamic> get params;
  bool get showMsg;

  /// Create a copy of QueryObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QueryObjectCopyWith<QueryObject> get copyWith =>
      _$QueryObjectCopyWithImpl<QueryObject>(this as QueryObject, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QueryObject &&
            (identical(other.querysql, querysql) ||
                other.querysql == querysql) &&
            const DeepCollectionEquality().equals(other.params, params) &&
            (identical(other.showMsg, showMsg) || other.showMsg == showMsg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, querysql,
      const DeepCollectionEquality().hash(params), showMsg);

  @override
  String toString() {
    return 'QueryObject(querysql: $querysql, params: $params, showMsg: $showMsg)';
  }
}

/// @nodoc
abstract mixin class $QueryObjectCopyWith<$Res> {
  factory $QueryObjectCopyWith(
          QueryObject value, $Res Function(QueryObject) _then) =
      _$QueryObjectCopyWithImpl;
  @useResult
  $Res call({String querysql, Map<String, dynamic> params, bool showMsg});
}

/// @nodoc
class _$QueryObjectCopyWithImpl<$Res> implements $QueryObjectCopyWith<$Res> {
  _$QueryObjectCopyWithImpl(this._self, this._then);

  final QueryObject _self;
  final $Res Function(QueryObject) _then;

  /// Create a copy of QueryObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? querysql = null,
    Object? params = null,
    Object? showMsg = null,
  }) {
    return _then(_self.copyWith(
      querysql: null == querysql
          ? _self.querysql
          : querysql // ignore: cast_nullable_to_non_nullable
              as String,
      params: null == params
          ? _self.params
          : params // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      showMsg: null == showMsg
          ? _self.showMsg
          : showMsg // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _QueryObject implements QueryObject {
  _QueryObject(
      {required this.querysql,
      required final Map<String, dynamic> params,
      required this.showMsg})
      : _params = params;

  @override
  final String querysql;
  final Map<String, dynamic> _params;
  @override
  Map<String, dynamic> get params {
    if (_params is EqualUnmodifiableMapView) return _params;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_params);
  }

  @override
  final bool showMsg;

  /// Create a copy of QueryObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QueryObjectCopyWith<_QueryObject> get copyWith =>
      __$QueryObjectCopyWithImpl<_QueryObject>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QueryObject &&
            (identical(other.querysql, querysql) ||
                other.querysql == querysql) &&
            const DeepCollectionEquality().equals(other._params, _params) &&
            (identical(other.showMsg, showMsg) || other.showMsg == showMsg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, querysql,
      const DeepCollectionEquality().hash(_params), showMsg);

  @override
  String toString() {
    return 'QueryObject(querysql: $querysql, params: $params, showMsg: $showMsg)';
  }
}

/// @nodoc
abstract mixin class _$QueryObjectCopyWith<$Res>
    implements $QueryObjectCopyWith<$Res> {
  factory _$QueryObjectCopyWith(
          _QueryObject value, $Res Function(_QueryObject) _then) =
      __$QueryObjectCopyWithImpl;
  @override
  @useResult
  $Res call({String querysql, Map<String, dynamic> params, bool showMsg});
}

/// @nodoc
class __$QueryObjectCopyWithImpl<$Res> implements _$QueryObjectCopyWith<$Res> {
  __$QueryObjectCopyWithImpl(this._self, this._then);

  final _QueryObject _self;
  final $Res Function(_QueryObject) _then;

  /// Create a copy of QueryObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? querysql = null,
    Object? params = null,
    Object? showMsg = null,
  }) {
    return _then(_QueryObject(
      querysql: null == querysql
          ? _self.querysql
          : querysql // ignore: cast_nullable_to_non_nullable
              as String,
      params: null == params
          ? _self._params
          : params // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      showMsg: null == showMsg
          ? _self.showMsg
          : showMsg // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
