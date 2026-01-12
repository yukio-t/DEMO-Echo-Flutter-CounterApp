// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'counter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CounterState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CounterState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CounterState()';
}


}

/// @nodoc
class $CounterStateCopyWith<$Res>  {
$CounterStateCopyWith(CounterState _, $Res Function(CounterState) __);
}


/// Adds pattern-matching-related methods to [CounterState].
extension CounterStatePatterns on CounterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CounterIdle value)?  idle,TResult Function( CounterLoading value)?  loading,TResult Function( CounterData value)?  data,TResult Function( CounterError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CounterIdle() when idle != null:
return idle(_that);case CounterLoading() when loading != null:
return loading(_that);case CounterData() when data != null:
return data(_that);case CounterError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CounterIdle value)  idle,required TResult Function( CounterLoading value)  loading,required TResult Function( CounterData value)  data,required TResult Function( CounterError value)  error,}){
final _that = this;
switch (_that) {
case CounterIdle():
return idle(_that);case CounterLoading():
return loading(_that);case CounterData():
return data(_that);case CounterError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CounterIdle value)?  idle,TResult? Function( CounterLoading value)?  loading,TResult? Function( CounterData value)?  data,TResult? Function( CounterError value)?  error,}){
final _that = this;
switch (_that) {
case CounterIdle() when idle != null:
return idle(_that);case CounterLoading() when loading != null:
return loading(_that);case CounterData() when data != null:
return data(_that);case CounterError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  loading,TResult Function( int value)?  data,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CounterIdle() when idle != null:
return idle();case CounterLoading() when loading != null:
return loading();case CounterData() when data != null:
return data(_that.value);case CounterError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  loading,required TResult Function( int value)  data,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case CounterIdle():
return idle();case CounterLoading():
return loading();case CounterData():
return data(_that.value);case CounterError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  loading,TResult? Function( int value)?  data,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case CounterIdle() when idle != null:
return idle();case CounterLoading() when loading != null:
return loading();case CounterData() when data != null:
return data(_that.value);case CounterError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CounterIdle implements CounterState {
  const CounterIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CounterIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CounterState.idle()';
}


}




/// @nodoc


class CounterLoading implements CounterState {
  const CounterLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CounterLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CounterState.loading()';
}


}




/// @nodoc


class CounterData implements CounterState {
  const CounterData({required this.value});
  

 final  int value;

/// Create a copy of CounterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CounterDataCopyWith<CounterData> get copyWith => _$CounterDataCopyWithImpl<CounterData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CounterData&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'CounterState.data(value: $value)';
}


}

/// @nodoc
abstract mixin class $CounterDataCopyWith<$Res> implements $CounterStateCopyWith<$Res> {
  factory $CounterDataCopyWith(CounterData value, $Res Function(CounterData) _then) = _$CounterDataCopyWithImpl;
@useResult
$Res call({
 int value
});




}
/// @nodoc
class _$CounterDataCopyWithImpl<$Res>
    implements $CounterDataCopyWith<$Res> {
  _$CounterDataCopyWithImpl(this._self, this._then);

  final CounterData _self;
  final $Res Function(CounterData) _then;

/// Create a copy of CounterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(CounterData(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class CounterError implements CounterState {
  const CounterError({required this.message});
  

 final  String message;

/// Create a copy of CounterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CounterErrorCopyWith<CounterError> get copyWith => _$CounterErrorCopyWithImpl<CounterError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CounterError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CounterState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CounterErrorCopyWith<$Res> implements $CounterStateCopyWith<$Res> {
  factory $CounterErrorCopyWith(CounterError value, $Res Function(CounterError) _then) = _$CounterErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CounterErrorCopyWithImpl<$Res>
    implements $CounterErrorCopyWith<$Res> {
  _$CounterErrorCopyWithImpl(this._self, this._then);

  final CounterError _self;
  final $Res Function(CounterError) _then;

/// Create a copy of CounterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CounterError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
