// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrolling_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scrollControllerNotifierHash() =>
    r'61ac93c076879c0c8ad421984d48414e26b734e5';

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

abstract class _$ScrollControllerNotifier
    extends BuildlessAutoDisposeNotifier<ScrollState> {
  late final ({double screenHeight, int sectionCount}) params;

  ScrollState build(({double screenHeight, int sectionCount}) params);
}

/// See also [ScrollControllerNotifier].
@ProviderFor(ScrollControllerNotifier)
const scrollControllerNotifierProvider = ScrollControllerNotifierFamily();

/// See also [ScrollControllerNotifier].
class ScrollControllerNotifierFamily extends Family<ScrollState> {
  /// See also [ScrollControllerNotifier].
  const ScrollControllerNotifierFamily();

  /// See also [ScrollControllerNotifier].
  ScrollControllerNotifierProvider call(
    ({double screenHeight, int sectionCount}) params,
  ) {
    return ScrollControllerNotifierProvider(params);
  }

  @override
  ScrollControllerNotifierProvider getProviderOverride(
    covariant ScrollControllerNotifierProvider provider,
  ) {
    return call(provider.params);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'scrollControllerNotifierProvider';
}

/// See also [ScrollControllerNotifier].
class ScrollControllerNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<ScrollControllerNotifier, ScrollState> {
  /// See also [ScrollControllerNotifier].
  ScrollControllerNotifierProvider(
    ({double screenHeight, int sectionCount}) params,
  ) : this._internal(
        () => ScrollControllerNotifier()..params = params,
        from: scrollControllerNotifierProvider,
        name: r'scrollControllerNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$scrollControllerNotifierHash,
        dependencies: ScrollControllerNotifierFamily._dependencies,
        allTransitiveDependencies:
            ScrollControllerNotifierFamily._allTransitiveDependencies,
        params: params,
      );

  ScrollControllerNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.params,
  }) : super.internal();

  final ({double screenHeight, int sectionCount}) params;

  @override
  ScrollState runNotifierBuild(covariant ScrollControllerNotifier notifier) {
    return notifier.build(params);
  }

  @override
  Override overrideWith(ScrollControllerNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ScrollControllerNotifierProvider._internal(
        () => create()..params = params,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        params: params,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ScrollControllerNotifier, ScrollState>
  createElement() {
    return _ScrollControllerNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ScrollControllerNotifierProvider && other.params == params;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ScrollControllerNotifierRef
    on AutoDisposeNotifierProviderRef<ScrollState> {
  /// The parameter `params` of this provider.
  ({double screenHeight, int sectionCount}) get params;
}

class _ScrollControllerNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          ScrollControllerNotifier,
          ScrollState
        >
    with ScrollControllerNotifierRef {
  _ScrollControllerNotifierProviderElement(super.provider);

  @override
  ({double screenHeight, int sectionCount}) get params =>
      (origin as ScrollControllerNotifierProvider).params;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
