// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acx_returndata_async.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$acxReturnDataHash() => r'718f273f06a27e904e1c62adce21c107b4f8d2c7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$AcxReturnData
    extends BuildlessAutoDisposeAsyncNotifier<Returndata> {
  late final QueryObject query;

  FutureOr<Returndata> build(
    QueryObject query,
  );
}

/// See also [AcxReturnData].
@ProviderFor(AcxReturnData)
const acxReturnDataProvider = AcxReturnDataFamily();

/// See also [AcxReturnData].
class AcxReturnDataFamily extends Family<AsyncValue<Returndata>> {
  /// See also [AcxReturnData].
  const AcxReturnDataFamily();

  /// See also [AcxReturnData].
  AcxReturnDataProvider call(
    QueryObject query,
  ) {
    return AcxReturnDataProvider(
      query,
    );
  }

  @override
  AcxReturnDataProvider getProviderOverride(
    covariant AcxReturnDataProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'acxReturnDataProvider';
}

/// See also [AcxReturnData].
class AcxReturnDataProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AcxReturnData, Returndata> {
  /// See also [AcxReturnData].
  AcxReturnDataProvider(
    QueryObject query,
  ) : this._internal(
          () => AcxReturnData()..query = query,
          from: acxReturnDataProvider,
          name: r'acxReturnDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$acxReturnDataHash,
          dependencies: AcxReturnDataFamily._dependencies,
          allTransitiveDependencies:
              AcxReturnDataFamily._allTransitiveDependencies,
          query: query,
        );

  AcxReturnDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final QueryObject query;

  @override
  FutureOr<Returndata> runNotifierBuild(
    covariant AcxReturnData notifier,
  ) {
    return notifier.build(
      query,
    );
  }

  @override
  Override overrideWith(AcxReturnData Function() create) {
    return ProviderOverride(
      origin: this,
      override: AcxReturnDataProvider._internal(
        () => create()..query = query,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AcxReturnData, Returndata>
      createElement() {
    return _AcxReturnDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AcxReturnDataProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AcxReturnDataRef on AutoDisposeAsyncNotifierProviderRef<Returndata> {
  /// The parameter `query` of this provider.
  QueryObject get query;
}

class _AcxReturnDataProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AcxReturnData, Returndata>
    with AcxReturnDataRef {
  _AcxReturnDataProviderElement(super.provider);

  @override
  QueryObject get query => (origin as AcxReturnDataProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
