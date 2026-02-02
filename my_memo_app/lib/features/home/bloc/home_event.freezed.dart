// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeEvent {

 ButtonType get buttonType;
/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeEventCopyWith<HomeEvent> get copyWith => _$HomeEventCopyWithImpl<HomeEvent>(this as HomeEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeEvent&&(identical(other.buttonType, buttonType) || other.buttonType == buttonType));
}


@override
int get hashCode => Object.hash(runtimeType,buttonType);

@override
String toString() {
  return 'HomeEvent(buttonType: $buttonType)';
}


}

/// @nodoc
abstract mixin class $HomeEventCopyWith<$Res>  {
  factory $HomeEventCopyWith(HomeEvent value, $Res Function(HomeEvent) _then) = _$HomeEventCopyWithImpl;
@useResult
$Res call({
 ButtonType buttonType
});




}
/// @nodoc
class _$HomeEventCopyWithImpl<$Res>
    implements $HomeEventCopyWith<$Res> {
  _$HomeEventCopyWithImpl(this._self, this._then);

  final HomeEvent _self;
  final $Res Function(HomeEvent) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? buttonType = null,}) {
  return _then(_self.copyWith(
buttonType: null == buttonType ? _self.buttonType : buttonType // ignore: cast_nullable_to_non_nullable
as ButtonType,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeEvent].
extension HomeEventPatterns on HomeEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SelectedButton value)?  selectedButton,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SelectedButton() when selectedButton != null:
return selectedButton(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SelectedButton value)  selectedButton,}){
final _that = this;
switch (_that) {
case SelectedButton():
return selectedButton(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SelectedButton value)?  selectedButton,}){
final _that = this;
switch (_that) {
case SelectedButton() when selectedButton != null:
return selectedButton(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ButtonType buttonType)?  selectedButton,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SelectedButton() when selectedButton != null:
return selectedButton(_that.buttonType);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ButtonType buttonType)  selectedButton,}) {final _that = this;
switch (_that) {
case SelectedButton():
return selectedButton(_that.buttonType);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ButtonType buttonType)?  selectedButton,}) {final _that = this;
switch (_that) {
case SelectedButton() when selectedButton != null:
return selectedButton(_that.buttonType);case _:
  return null;

}
}

}

/// @nodoc


class SelectedButton implements HomeEvent {
  const SelectedButton({required this.buttonType});
  

@override final  ButtonType buttonType;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectedButtonCopyWith<SelectedButton> get copyWith => _$SelectedButtonCopyWithImpl<SelectedButton>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectedButton&&(identical(other.buttonType, buttonType) || other.buttonType == buttonType));
}


@override
int get hashCode => Object.hash(runtimeType,buttonType);

@override
String toString() {
  return 'HomeEvent.selectedButton(buttonType: $buttonType)';
}


}

/// @nodoc
abstract mixin class $SelectedButtonCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory $SelectedButtonCopyWith(SelectedButton value, $Res Function(SelectedButton) _then) = _$SelectedButtonCopyWithImpl;
@override @useResult
$Res call({
 ButtonType buttonType
});




}
/// @nodoc
class _$SelectedButtonCopyWithImpl<$Res>
    implements $SelectedButtonCopyWith<$Res> {
  _$SelectedButtonCopyWithImpl(this._self, this._then);

  final SelectedButton _self;
  final $Res Function(SelectedButton) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? buttonType = null,}) {
  return _then(SelectedButton(
buttonType: null == buttonType ? _self.buttonType : buttonType // ignore: cast_nullable_to_non_nullable
as ButtonType,
  ));
}


}

// dart format on
