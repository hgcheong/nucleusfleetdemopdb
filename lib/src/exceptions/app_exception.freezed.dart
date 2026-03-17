// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppException {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AppException);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AppException()';
  }
}

/// @nodoc
class $AppExceptionCopyWith<$Res> {
  $AppExceptionCopyWith(AppException _, $Res Function(AppException) __);
}

/// @nodoc

class EmailAlreadyInUse implements AppException {
  const EmailAlreadyInUse();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EmailAlreadyInUse);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AppException.emailAlreadyInUse()';
  }
}

/// @nodoc

class WeakPassword implements AppException {
  const WeakPassword();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is WeakPassword);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AppException.weakPassword()';
  }
}

/// @nodoc

class WrongPassword implements AppException {
  const WrongPassword();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is WrongPassword);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AppException.wrongPassword()';
  }
}

/// @nodoc

class UserNotFound implements AppException {
  const UserNotFound();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UserNotFound);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AppException.userNotFound()';
  }
}

/// @nodoc

class ParseOrderFailure implements AppException {
  const ParseOrderFailure(this.status);

  final String status;

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParseOrderFailureCopyWith<ParseOrderFailure> get copyWith =>
      _$ParseOrderFailureCopyWithImpl<ParseOrderFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParseOrderFailure &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  String toString() {
    return 'AppException.parseOrderFailure(status: $status)';
  }
}

/// @nodoc
abstract mixin class $ParseOrderFailureCopyWith<$Res>
    implements $AppExceptionCopyWith<$Res> {
  factory $ParseOrderFailureCopyWith(
          ParseOrderFailure value, $Res Function(ParseOrderFailure) _then) =
      _$ParseOrderFailureCopyWithImpl;
  @useResult
  $Res call({String status});
}

/// @nodoc
class _$ParseOrderFailureCopyWithImpl<$Res>
    implements $ParseOrderFailureCopyWith<$Res> {
  _$ParseOrderFailureCopyWithImpl(this._self, this._then);

  final ParseOrderFailure _self;
  final $Res Function(ParseOrderFailure) _then;

  /// Create a copy of AppException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
  }) {
    return _then(ParseOrderFailure(
      null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
