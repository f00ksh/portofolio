// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scrolling_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScrollState {

 double get offset; double get screenHeight; bool get isScrolling; int get currentSectionIndex;
/// Create a copy of ScrollState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScrollStateCopyWith<ScrollState> get copyWith => _$ScrollStateCopyWithImpl<ScrollState>(this as ScrollState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScrollState&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.screenHeight, screenHeight) || other.screenHeight == screenHeight)&&(identical(other.isScrolling, isScrolling) || other.isScrolling == isScrolling)&&(identical(other.currentSectionIndex, currentSectionIndex) || other.currentSectionIndex == currentSectionIndex));
}


@override
int get hashCode => Object.hash(runtimeType,offset,screenHeight,isScrolling,currentSectionIndex);

@override
String toString() {
  return 'ScrollState(offset: $offset, screenHeight: $screenHeight, isScrolling: $isScrolling, currentSectionIndex: $currentSectionIndex)';
}


}

/// @nodoc
abstract mixin class $ScrollStateCopyWith<$Res>  {
  factory $ScrollStateCopyWith(ScrollState value, $Res Function(ScrollState) _then) = _$ScrollStateCopyWithImpl;
@useResult
$Res call({
 double offset, double screenHeight, bool isScrolling, int currentSectionIndex
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
@pragma('vm:prefer-inline') @override $Res call({Object? offset = null,Object? screenHeight = null,Object? isScrolling = null,Object? currentSectionIndex = null,}) {
  return _then(_self.copyWith(
offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as double,screenHeight: null == screenHeight ? _self.screenHeight : screenHeight // ignore: cast_nullable_to_non_nullable
as double,isScrolling: null == isScrolling ? _self.isScrolling : isScrolling // ignore: cast_nullable_to_non_nullable
as bool,currentSectionIndex: null == currentSectionIndex ? _self.currentSectionIndex : currentSectionIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _ScrollState implements ScrollState {
  const _ScrollState({this.offset = 0.0, this.screenHeight = 0.0, this.isScrolling = false, this.currentSectionIndex = 0});
  

@override@JsonKey() final  double offset;
@override@JsonKey() final  double screenHeight;
@override@JsonKey() final  bool isScrolling;
@override@JsonKey() final  int currentSectionIndex;

/// Create a copy of ScrollState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScrollStateCopyWith<_ScrollState> get copyWith => __$ScrollStateCopyWithImpl<_ScrollState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScrollState&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.screenHeight, screenHeight) || other.screenHeight == screenHeight)&&(identical(other.isScrolling, isScrolling) || other.isScrolling == isScrolling)&&(identical(other.currentSectionIndex, currentSectionIndex) || other.currentSectionIndex == currentSectionIndex));
}


@override
int get hashCode => Object.hash(runtimeType,offset,screenHeight,isScrolling,currentSectionIndex);

@override
String toString() {
  return 'ScrollState(offset: $offset, screenHeight: $screenHeight, isScrolling: $isScrolling, currentSectionIndex: $currentSectionIndex)';
}


}

/// @nodoc
abstract mixin class _$ScrollStateCopyWith<$Res> implements $ScrollStateCopyWith<$Res> {
  factory _$ScrollStateCopyWith(_ScrollState value, $Res Function(_ScrollState) _then) = __$ScrollStateCopyWithImpl;
@override @useResult
$Res call({
 double offset, double screenHeight, bool isScrolling, int currentSectionIndex
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
@override @pragma('vm:prefer-inline') $Res call({Object? offset = null,Object? screenHeight = null,Object? isScrolling = null,Object? currentSectionIndex = null,}) {
  return _then(_ScrollState(
offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as double,screenHeight: null == screenHeight ? _self.screenHeight : screenHeight // ignore: cast_nullable_to_non_nullable
as double,isScrolling: null == isScrolling ? _self.isScrolling : isScrolling // ignore: cast_nullable_to_non_nullable
as bool,currentSectionIndex: null == currentSectionIndex ? _self.currentSectionIndex : currentSectionIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
