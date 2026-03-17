// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acx_returndata_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$returndataHash() => r'bed732b31b8b550f398fb29cfa7724c7fb763951';

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

/// See also [returndata].
@ProviderFor(returndata)
const returndataProvider = ReturndataFamily();

/// See also [returndata].
class ReturndataFamily extends Family<AsyncValue<Returndata>> {
  /// See also [returndata].
  const ReturndataFamily();

  /// See also [returndata].
  ReturndataProvider call({
    required String querysql,
    required Map<String, dynamic> params,
    bool showMsg = false,
  }) {
    return ReturndataProvider(
      querysql: querysql,
      params: params,
      showMsg: showMsg,
    );
  }

  @override
  ReturndataProvider getProviderOverride(
    covariant ReturndataProvider provider,
  ) {
    return call(
      querysql: provider.querysql,
      params: provider.params,
      showMsg: provider.showMsg,
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
  String? get name => r'returndataProvider';
}

/// See also [returndata].
class ReturndataProvider extends AutoDisposeFutureProvider<Returndata> {
  /// See also [returndata].
  ReturndataProvider({
    required String querysql,
    required Map<String, dynamic> params,
    bool showMsg = false,
  }) : this._internal(
          (ref) => returndata(
            ref as ReturndataRef,
            querysql: querysql,
            params: params,
            showMsg: showMsg,
          ),
          from: returndataProvider,
          name: r'returndataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$returndataHash,
          dependencies: ReturndataFamily._dependencies,
          allTransitiveDependencies:
              ReturndataFamily._allTransitiveDependencies,
          querysql: querysql,
          params: params,
          showMsg: showMsg,
        );

  ReturndataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.querysql,
    required this.params,
    required this.showMsg,
  }) : super.internal();

  final String querysql;
  final Map<String, dynamic> params;
  final bool showMsg;

  @override
  Override overrideWith(
    FutureOr<Returndata> Function(ReturndataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReturndataProvider._internal(
        (ref) => create(ref as ReturndataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        querysql: querysql,
        params: params,
        showMsg: showMsg,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Returndata> createElement() {
    return _ReturndataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReturndataProvider &&
        other.querysql == querysql &&
        other.params == params &&
        other.showMsg == showMsg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, querysql.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);
    hash = _SystemHash.combine(hash, showMsg.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReturndataRef on AutoDisposeFutureProviderRef<Returndata> {
  /// The parameter `querysql` of this provider.
  String get querysql;

  /// The parameter `params` of this provider.
  Map<String, dynamic> get params;

  /// The parameter `showMsg` of this provider.
  bool get showMsg;
}

class _ReturndataProviderElement
    extends AutoDisposeFutureProviderElement<Returndata> with ReturndataRef {
  _ReturndataProviderElement(super.provider);

  @override
  String get querysql => (origin as ReturndataProvider).querysql;
  @override
  Map<String, dynamic> get params => (origin as ReturndataProvider).params;
  @override
  bool get showMsg => (origin as ReturndataProvider).showMsg;
}

String _$multireturndataHash() => r'a7a62053b75f68af2f7eef604d9ccb6325220549';

/// See also [multireturndata].
@ProviderFor(multireturndata)
const multireturndataProvider = MultireturndataFamily();

/// See also [multireturndata].
class MultireturndataFamily extends Family<AsyncValue<MultiReturndata>> {
  /// See also [multireturndata].
  const MultireturndataFamily();

  /// See also [multireturndata].
  MultireturndataProvider call({
    required String querysql,
    required Map<String, dynamic> params,
    bool showMsg = false,
  }) {
    return MultireturndataProvider(
      querysql: querysql,
      params: params,
      showMsg: showMsg,
    );
  }

  @override
  MultireturndataProvider getProviderOverride(
    covariant MultireturndataProvider provider,
  ) {
    return call(
      querysql: provider.querysql,
      params: provider.params,
      showMsg: provider.showMsg,
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
  String? get name => r'multireturndataProvider';
}

/// See also [multireturndata].
class MultireturndataProvider
    extends AutoDisposeFutureProvider<MultiReturndata> {
  /// See also [multireturndata].
  MultireturndataProvider({
    required String querysql,
    required Map<String, dynamic> params,
    bool showMsg = false,
  }) : this._internal(
          (ref) => multireturndata(
            ref as MultireturndataRef,
            querysql: querysql,
            params: params,
            showMsg: showMsg,
          ),
          from: multireturndataProvider,
          name: r'multireturndataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$multireturndataHash,
          dependencies: MultireturndataFamily._dependencies,
          allTransitiveDependencies:
              MultireturndataFamily._allTransitiveDependencies,
          querysql: querysql,
          params: params,
          showMsg: showMsg,
        );

  MultireturndataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.querysql,
    required this.params,
    required this.showMsg,
  }) : super.internal();

  final String querysql;
  final Map<String, dynamic> params;
  final bool showMsg;

  @override
  Override overrideWith(
    FutureOr<MultiReturndata> Function(MultireturndataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MultireturndataProvider._internal(
        (ref) => create(ref as MultireturndataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        querysql: querysql,
        params: params,
        showMsg: showMsg,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<MultiReturndata> createElement() {
    return _MultireturndataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MultireturndataProvider &&
        other.querysql == querysql &&
        other.params == params &&
        other.showMsg == showMsg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, querysql.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);
    hash = _SystemHash.combine(hash, showMsg.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MultireturndataRef on AutoDisposeFutureProviderRef<MultiReturndata> {
  /// The parameter `querysql` of this provider.
  String get querysql;

  /// The parameter `params` of this provider.
  Map<String, dynamic> get params;

  /// The parameter `showMsg` of this provider.
  bool get showMsg;
}

class _MultireturndataProviderElement
    extends AutoDisposeFutureProviderElement<MultiReturndata>
    with MultireturndataRef {
  _MultireturndataProviderElement(super.provider);

  @override
  String get querysql => (origin as MultireturndataProvider).querysql;
  @override
  Map<String, dynamic> get params => (origin as MultireturndataProvider).params;
  @override
  bool get showMsg => (origin as MultireturndataProvider).showMsg;
}

String _$returndatafreezedHash() => r'322125d981bcc64896e3b6c53aca0df66cf11c09';

/// See also [returndatafreezed].
@ProviderFor(returndatafreezed)
const returndatafreezedProvider = ReturndatafreezedFamily();

/// See also [returndatafreezed].
class ReturndatafreezedFamily extends Family<AsyncValue<Returndata>> {
  /// See also [returndatafreezed].
  const ReturndatafreezedFamily();

  /// See also [returndatafreezed].
  ReturndatafreezedProvider call(
    QueryObject query,
  ) {
    return ReturndatafreezedProvider(
      query,
    );
  }

  @override
  ReturndatafreezedProvider getProviderOverride(
    covariant ReturndatafreezedProvider provider,
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
  String? get name => r'returndatafreezedProvider';
}

/// See also [returndatafreezed].
class ReturndatafreezedProvider extends AutoDisposeFutureProvider<Returndata> {
  /// See also [returndatafreezed].
  ReturndatafreezedProvider(
    QueryObject query,
  ) : this._internal(
          (ref) => returndatafreezed(
            ref as ReturndatafreezedRef,
            query,
          ),
          from: returndatafreezedProvider,
          name: r'returndatafreezedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$returndatafreezedHash,
          dependencies: ReturndatafreezedFamily._dependencies,
          allTransitiveDependencies:
              ReturndatafreezedFamily._allTransitiveDependencies,
          query: query,
        );

  ReturndatafreezedProvider._internal(
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
    FutureOr<Returndata> Function(ReturndatafreezedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReturndatafreezedProvider._internal(
        (ref) => create(ref as ReturndatafreezedRef),
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
  AutoDisposeFutureProviderElement<Returndata> createElement() {
    return _ReturndatafreezedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReturndatafreezedProvider && other.query == query;
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
mixin ReturndatafreezedRef on AutoDisposeFutureProviderRef<Returndata> {
  /// The parameter `query` of this provider.
  QueryObject get query;
}

class _ReturndatafreezedProviderElement
    extends AutoDisposeFutureProviderElement<Returndata>
    with ReturndatafreezedRef {
  _ReturndatafreezedProviderElement(super.provider);

  @override
  QueryObject get query => (origin as ReturndatafreezedProvider).query;
}

String _$returndatafreezedwTitleHash() =>
    r'72511ffe5296495b0379f10dbf40504a4f309061';

/// See also [returndatafreezedwTitle].
@ProviderFor(returndatafreezedwTitle)
const returndatafreezedwTitleProvider = ReturndatafreezedwTitleFamily();

/// See also [returndatafreezedwTitle].
class ReturndatafreezedwTitleFamily extends Family<AsyncValue<Returndata>> {
  /// See also [returndatafreezedwTitle].
  const ReturndatafreezedwTitleFamily();

  /// See also [returndatafreezedwTitle].
  ReturndatafreezedwTitleProvider call(
    QueryObject query,
    QueryObject titleQuery,
  ) {
    return ReturndatafreezedwTitleProvider(
      query,
      titleQuery,
    );
  }

  @override
  ReturndatafreezedwTitleProvider getProviderOverride(
    covariant ReturndatafreezedwTitleProvider provider,
  ) {
    return call(
      provider.query,
      provider.titleQuery,
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
  String? get name => r'returndatafreezedwTitleProvider';
}

/// See also [returndatafreezedwTitle].
class ReturndatafreezedwTitleProvider
    extends AutoDisposeFutureProvider<Returndata> {
  /// See also [returndatafreezedwTitle].
  ReturndatafreezedwTitleProvider(
    QueryObject query,
    QueryObject titleQuery,
  ) : this._internal(
          (ref) => returndatafreezedwTitle(
            ref as ReturndatafreezedwTitleRef,
            query,
            titleQuery,
          ),
          from: returndatafreezedwTitleProvider,
          name: r'returndatafreezedwTitleProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$returndatafreezedwTitleHash,
          dependencies: ReturndatafreezedwTitleFamily._dependencies,
          allTransitiveDependencies:
              ReturndatafreezedwTitleFamily._allTransitiveDependencies,
          query: query,
          titleQuery: titleQuery,
        );

  ReturndatafreezedwTitleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
    required this.titleQuery,
  }) : super.internal();

  final QueryObject query;
  final QueryObject titleQuery;

  @override
  Override overrideWith(
    FutureOr<Returndata> Function(ReturndatafreezedwTitleRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReturndatafreezedwTitleProvider._internal(
        (ref) => create(ref as ReturndatafreezedwTitleRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
        titleQuery: titleQuery,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Returndata> createElement() {
    return _ReturndatafreezedwTitleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReturndatafreezedwTitleProvider &&
        other.query == query &&
        other.titleQuery == titleQuery;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, titleQuery.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReturndatafreezedwTitleRef on AutoDisposeFutureProviderRef<Returndata> {
  /// The parameter `query` of this provider.
  QueryObject get query;

  /// The parameter `titleQuery` of this provider.
  QueryObject get titleQuery;
}

class _ReturndatafreezedwTitleProviderElement
    extends AutoDisposeFutureProviderElement<Returndata>
    with ReturndatafreezedwTitleRef {
  _ReturndatafreezedwTitleProviderElement(super.provider);

  @override
  QueryObject get query => (origin as ReturndatafreezedwTitleProvider).query;
  @override
  QueryObject get titleQuery =>
      (origin as ReturndatafreezedwTitleProvider).titleQuery;
}

String _$multireturndatafreezedHash() =>
    r'9b2a776034745aee35cc08286ee1973fbe6f05c6';

/// See also [multireturndatafreezed].
@ProviderFor(multireturndatafreezed)
const multireturndatafreezedProvider = MultireturndatafreezedFamily();

/// See also [multireturndatafreezed].
class MultireturndatafreezedFamily extends Family<AsyncValue<MultiReturndata>> {
  /// See also [multireturndatafreezed].
  const MultireturndatafreezedFamily();

  /// See also [multireturndatafreezed].
  MultireturndatafreezedProvider call(
    QueryObject query,
  ) {
    return MultireturndatafreezedProvider(
      query,
    );
  }

  @override
  MultireturndatafreezedProvider getProviderOverride(
    covariant MultireturndatafreezedProvider provider,
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
  String? get name => r'multireturndatafreezedProvider';
}

/// See also [multireturndatafreezed].
class MultireturndatafreezedProvider
    extends AutoDisposeFutureProvider<MultiReturndata> {
  /// See also [multireturndatafreezed].
  MultireturndatafreezedProvider(
    QueryObject query,
  ) : this._internal(
          (ref) => multireturndatafreezed(
            ref as MultireturndatafreezedRef,
            query,
          ),
          from: multireturndatafreezedProvider,
          name: r'multireturndatafreezedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$multireturndatafreezedHash,
          dependencies: MultireturndatafreezedFamily._dependencies,
          allTransitiveDependencies:
              MultireturndatafreezedFamily._allTransitiveDependencies,
          query: query,
        );

  MultireturndatafreezedProvider._internal(
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
    FutureOr<MultiReturndata> Function(MultireturndatafreezedRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MultireturndatafreezedProvider._internal(
        (ref) => create(ref as MultireturndatafreezedRef),
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
  AutoDisposeFutureProviderElement<MultiReturndata> createElement() {
    return _MultireturndatafreezedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MultireturndatafreezedProvider && other.query == query;
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
mixin MultireturndatafreezedRef
    on AutoDisposeFutureProviderRef<MultiReturndata> {
  /// The parameter `query` of this provider.
  QueryObject get query;
}

class _MultireturndatafreezedProviderElement
    extends AutoDisposeFutureProviderElement<MultiReturndata>
    with MultireturndatafreezedRef {
  _MultireturndatafreezedProviderElement(super.provider);

  @override
  QueryObject get query => (origin as MultireturndatafreezedProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
