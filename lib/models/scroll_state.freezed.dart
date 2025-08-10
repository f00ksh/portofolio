// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scroll_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScrollState {

 double get offset; int get currentSection; double get sectionProgress; bool get isScrolling; bool get isNavigationVisible; double get scrollDirection;
/// Create a copy of ScrollState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScrollStateCopyWith<ScrollState> get copyWith => _$ScrollStateCopyWithImpl<ScrollState>(this as ScrollState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScrollState&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.currentSection, currentSection) || other.currentSection == currentSection)&&(identical(other.sectionProgress, sectionProgress) || other.sectionProgress == sectionProgress)&&(identical(other.isScrolling, isScrolling) || other.isScrolling == isScrolling)&&(identical(other.isNavigationVisible, isNavigationVisible) || other.isNavigationVisible == isNavigationVisible)&&(identical(other.scrollDirection, scrollDirection) || other.scrollDirection == scrollDirection));
}


@override
int get hashCode => Object.hash(runtimeType,offset,currentSection,sectionProgress,isScrolling,isNavigationVisible,scrollDirection);

@override
String toString() {
  return 'ScrollState(offset: $offset, currentSection: $currentSection, sectionProgress: $sectionProgress, isScrolling: $isScrolling, isNavigationVisible: $isNavigationVisible, scrollDirection: $scrollDirection)';
}


}

/// @nodoc
abstract mixin class $ScrollStateCopyWith<$Res>  {
  factory $ScrollStateCopyWith(ScrollState value, $Res Function(ScrollState) _then) = _$ScrollStateCopyWithImpl;
@useResult
$Res call({
 double offset, int currentSection, double sectionProgress, bool isScrolling, bool isNavigationVisible, double scrollDirection
});




}
/// @nodoc
class _$ScrollStateCopyWithImpl<$Res>
    implements $ScrollStateCopyWith<$Res> {
  _$ScrollStateCopyWithImpl(this._self, this._then);

  final ScrollState _self;
  final $Res Function(ScrollState) _then;

/// Create a copy of ScrollState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? offset = null,Object? currentSection = null,Object? sectionProgress = null,Object? isScrolling = null,Object? isNavigationVisible = null,Object? scrollDirection = null,}) {
  return _then(_self.copyWith(
offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as double,currentSection: null == currentSection ? _self.currentSection : currentSection // ignore: cast_nullable_to_non_nullable
as int,sectionProgress: null == sectionProgress ? _self.sectionProgress : sectionProgress // ignore: cast_nullable_to_non_nullable
as double,isScrolling: null == isScrolling ? _self.isScrolling : isScrolling // ignore: cast_nullable_to_non_nullable
as bool,isNavigationVisible: null == isNavigationVisible ? _self.isNavigationVisible : isNavigationVisible // ignore: cast_nullable_to_non_nullable
as bool,scrollDirection: null == scrollDirection ? _self.scrollDirection : scrollDirection // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc


class _ScrollState implements ScrollState {
  const _ScrollState({required this.offset, required this.currentSection, required this.sectionProgress, required this.isScrolling, required this.isNavigationVisible, required this.scrollDirection});
  

@override final  double offset;
@override final  int currentSection;
@override final  double sectionProgress;
@override final  bool isScrolling;
@override final  bool isNavigationVisible;
@override final  double scrollDirection;

/// Create a copy of ScrollState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScrollStateCopyWith<_ScrollState> get copyWith => __$ScrollStateCopyWithImpl<_ScrollState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScrollState&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.currentSection, currentSection) || other.currentSection == currentSection)&&(identical(other.sectionProgress, sectionProgress) || other.sectionProgress == sectionProgress)&&(identical(other.isScrolling, isScrolling) || other.isScrolling == isScrolling)&&(identical(other.isNavigationVisible, isNavigationVisible) || other.isNavigationVisible == isNavigationVisible)&&(identical(other.scrollDirection, scrollDirection) || other.scrollDirection == scrollDirection));
}


@override
int get hashCode => Object.hash(runtimeType,offset,currentSection,sectionProgress,isScrolling,isNavigationVisible,scrollDirection);

@override
String toString() {
  return 'ScrollState(offset: $offset, currentSection: $currentSection, sectionProgress: $sectionProgress, isScrolling: $isScrolling, isNavigationVisible: $isNavigationVisible, scrollDirection: $scrollDirection)';
}


}

/// @nodoc
abstract mixin class _$ScrollStateCopyWith<$Res> implements $ScrollStateCopyWith<$Res> {
  factory _$ScrollStateCopyWith(_ScrollState value, $Res Function(_ScrollState) _then) = __$ScrollStateCopyWithImpl;
@override @useResult
$Res call({
 double offset, int currentSection, double sectionProgress, bool isScrolling, bool isNavigationVisible, double scrollDirection
});




}
/// @nodoc
class __$ScrollStateCopyWithImpl<$Res>
    implements _$ScrollStateCopyWith<$Res> {
  __$ScrollStateCopyWithImpl(this._self, this._then);

  final _ScrollState _self;
  final $Res Function(_ScrollState) _then;

/// Create a copy of ScrollState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? offset = null,Object? currentSection = null,Object? sectionProgress = null,Object? isScrolling = null,Object? isNavigationVisible = null,Object? scrollDirection = null,}) {
  return _then(_ScrollState(
offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as double,currentSection: null == currentSection ? _self.currentSection : currentSection // ignore: cast_nullable_to_non_nullable
as int,sectionProgress: null == sectionProgress ? _self.sectionProgress : sectionProgress // ignore: cast_nullable_to_non_nullable
as double,isScrolling: null == isScrolling ? _self.isScrolling : isScrolling // ignore: cast_nullable_to_non_nullable
as bool,isNavigationVisible: null == isNavigationVisible ? _self.isNavigationVisible : isNavigationVisible // ignore: cast_nullable_to_non_nullable
as bool,scrollDirection: null == scrollDirection ? _self.scrollDirection : scrollDirection // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
