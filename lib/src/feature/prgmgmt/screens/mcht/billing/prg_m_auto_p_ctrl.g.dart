// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prg_m_auto_p_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$prgmautopFormDataHash() => r'2cca5f6d419a278c51937bedcc553d9e9068f2f0';

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

/// See also [prgmautopFormData].
@ProviderFor(prgmautopFormData)
const prgmautopFormDataProvider = PrgmautopFormDataFamily();

/// See also [prgmautopFormData].
class PrgmautopFormDataFamily extends Family<AsyncValue<Returndata>> {
  /// See also [prgmautopFormData].
  const PrgmautopFormDataFamily();

  /// See also [prgmautopFormData].
  PrgmautopFormDataProvider call(
    QueryObject query,
  ) {
    return PrgmautopFormDataProvider(
      query,
    );
  }

  @override
  PrgmautopFormDataProvider getProviderOverride(
    covariant PrgmautopFormDataProvider provider,
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
  String? get name => r'prgmautopFormDataProvider';
}

/// See also [prgmautopFormData].
class PrgmautopFormDataProvider extends FutureProvider<Returndata> {
  /// See also [prgmautopFormData].
  PrgmautopFormDataProvider(
    QueryObject query,
  ) : this._internal(
          (ref) => prgmautopFormData(
            ref as PrgmautopFormDataRef,
            query,
          ),
          from: prgmautopFormDataProvider,
          name: r'prgmautopFormDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$prgmautopFormDataHash,
          dependencies: PrgmautopFormDataFamily._dependencies,
          allTransitiveDependencies:
              PrgmautopFormDataFamily._allTransitiveDependencies,
          query: query,
        );

  PrgmautopFormDataProvider._internal(
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
  Override overrideWith(
    FutureOr<Returndata> Function(PrgmautopFormDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PrgmautopFormDataProvider._internal(
        (ref) => create(ref as PrgmautopFormDataRef),
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
  FutureProviderElement<Returndata> createElement() {
    return _PrgmautopFormDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PrgmautopFormDataProvider && other.query == query;
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
mixin PrgmautopFormDataRef on FutureProviderRef<Returndata> {
  /// The parameter `query` of this provider.
  QueryObject get query;
}

class _PrgmautopFormDataProviderElement
    extends FutureProviderElement<Returndata> with PrgmautopFormDataRef {
  _PrgmautopFormDataProviderElement(super.provider);

  @override
  QueryObject get query => (origin as PrgmautopFormDataProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
