// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrolling_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scrollOffsetHash() => r'd43c5d3348cb8d6307ae3f2bdf65bf0cc8a125e1';

/// See also [scrollOffset].
@ProviderFor(scrollOffset)
final scrollOffsetProvider = AutoDisposeProvider<double>.internal(
  scrollOffset,
  name: r'scrollOffsetProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$scrollOffsetHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ScrollOffsetRef = AutoDisposeProviderRef<double>;
String _$currentSectionHash() => r'425d2f91a9b65c5df4144125e122e1a88124e85e';

/// See also [currentSection].
@ProviderFor(currentSection)
final currentSectionProvider = AutoDisposeProvider<int>.internal(
  currentSection,
  name: r'currentSectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentSectionRef = AutoDisposeProviderRef<int>;
String _$isScrollingHash() => r'a38c068b2ee7fa316247c75c460693ca250f1991';

/// See also [isScrolling].
@ProviderFor(isScrolling)
final isScrollingProvider = AutoDisposeProvider<bool>.internal(
  isScrolling,
  name: r'isScrollingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isScrollingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsScrollingRef = AutoDisposeProviderRef<bool>;
String _$effectiveScreenHeightHash() =>
    r'e59c589040e7d40e9b9044ada676ee3c50490ab0';

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

/// See also [effectiveScreenHeight].
@ProviderFor(effectiveScreenHeight)
const effectiveScreenHeightProvider = EffectiveScreenHeightFamily();

/// See also [effectiveScreenHeight].
class EffectiveScreenHeightFamily extends Family<double> {
  /// See also [effectiveScreenHeight].
  const EffectiveScreenHeightFamily();

  /// See also [effectiveScreenHeight].
  EffectiveScreenHeightProvider call(BuildContext context) {
    return EffectiveScreenHeightProvider(context);
  }

  @override
  EffectiveScreenHeightProvider getProviderOverride(
    covariant EffectiveScreenHeightProvider provider,
  ) {
    return call(provider.context);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'effectiveScreenHeightProvider';
}

/// See also [effectiveScreenHeight].
class EffectiveScreenHeightProvider extends AutoDisposeProvider<double> {
  /// See also [effectiveScreenHeight].
  EffectiveScreenHeightProvider(BuildContext context)
    : this._internal(
        (ref) =>
            effectiveScreenHeight(ref as EffectiveScreenHeightRef, context),
        from: effectiveScreenHeightProvider,
        name: r'effectiveScreenHeightProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$effectiveScreenHeightHash,
        dependencies: EffectiveScreenHeightFamily._dependencies,
        allTransitiveDependencies:
            EffectiveScreenHeightFamily._allTransitiveDependencies,
        context: context,
      );

  EffectiveScreenHeightProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
  }) : super.internal();

  final BuildContext context;

  @override
  Override overrideWith(
    double Function(EffectiveScreenHeightRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EffectiveScreenHeightProvider._internal(
        (ref) => create(ref as EffectiveScreenHeightRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<double> createElement() {
    return _EffectiveScreenHeightProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EffectiveScreenHeightProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EffectiveScreenHeightRef on AutoDisposeProviderRef<double> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _EffectiveScreenHeightProviderElement
    extends AutoDisposeProviderElement<double>
    with EffectiveScreenHeightRef {
  _EffectiveScreenHeightProviderElement(super.provider);

  @override
  BuildContext get context => (origin as EffectiveScreenHeightProvider).context;
}

String _$totalHeightHash() => r'95a0a93184b96ae02652921a063d9e59e0c4f005';

/// See also [totalHeight].
@ProviderFor(totalHeight)
const totalHeightProvider = TotalHeightFamily();

/// See also [totalHeight].
class TotalHeightFamily extends Family<double> {
  /// See also [totalHeight].
  const TotalHeightFamily();

  /// See also [totalHeight].
  TotalHeightProvider call(BuildContext context, int widgetCount) {
    return TotalHeightProvider(context, widgetCount);
  }

  @override
  TotalHeightProvider getProviderOverride(
    covariant TotalHeightProvider provider,
  ) {
    return call(provider.context, provider.widgetCount);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'totalHeightProvider';
}

/// See also [totalHeight].
class TotalHeightProvider extends AutoDisposeProvider<double> {
  /// See also [totalHeight].
  TotalHeightProvider(BuildContext context, int widgetCount)
    : this._internal(
        (ref) => totalHeight(ref as TotalHeightRef, context, widgetCount),
        from: totalHeightProvider,
        name: r'totalHeightProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$totalHeightHash,
        dependencies: TotalHeightFamily._dependencies,
        allTransitiveDependencies: TotalHeightFamily._allTransitiveDependencies,
        context: context,
        widgetCount: widgetCount,
      );

  TotalHeightProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.widgetCount,
  }) : super.internal();

  final BuildContext context;
  final int widgetCount;

  @override
  Override overrideWith(double Function(TotalHeightRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: TotalHeightProvider._internal(
        (ref) => create(ref as TotalHeightRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        widgetCount: widgetCount,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<double> createElement() {
    return _TotalHeightProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TotalHeightProvider &&
        other.context == context &&
        other.widgetCount == widgetCount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, widgetCount.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TotalHeightRef on AutoDisposeProviderRef<double> {
  /// The parameter `context` of this provider.
  BuildContext get context;

  /// The parameter `widgetCount` of this provider.
  int get widgetCount;
}

class _TotalHeightProviderElement extends AutoDisposeProviderElement<double>
    with TotalHeightRef {
  _TotalHeightProviderElement(super.provider);

  @override
  BuildContext get context => (origin as TotalHeightProvider).context;
  @override
  int get widgetCount => (origin as TotalHeightProvider).widgetCount;
}

String _$scrollControllerHash() => r'066076c17943fbd8c228a1c09617c3cd6de613eb';

/// See also [ScrollController].
@ProviderFor(ScrollController)
final scrollControllerProvider =
    AutoDisposeNotifierProvider<
      ScrollController,
      flutter.ScrollController
    >.internal(
      ScrollController.new,
      name: r'scrollControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$scrollControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ScrollController = AutoDisposeNotifier<flutter.ScrollController>;
String _$scrollStateNotifierHash() =>
    r'8572c0f37b3eb5c8d525b8c6903c90b0752d690c';

/// See also [ScrollStateNotifier].
@ProviderFor(ScrollStateNotifier)
final scrollStateNotifierProvider =
    AutoDisposeNotifierProvider<ScrollStateNotifier, ScrollState>.internal(
      ScrollStateNotifier.new,
      name: r'scrollStateNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$scrollStateNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ScrollStateNotifier = AutoDisposeNotifier<ScrollState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
