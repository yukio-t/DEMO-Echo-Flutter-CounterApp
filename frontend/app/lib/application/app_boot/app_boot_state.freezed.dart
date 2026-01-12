// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_boot_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppBootState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBootState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppBootState()';
}


}

/// @nodoc
class $AppBootStateCopyWith<$Res>  {
$AppBootStateCopyWith(AppBootState _, $Res Function(AppBootState) __);
}


/// Adds pattern-matching-related methods to [AppBootState].
extension AppBootStatePatterns on AppBootState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AppBootIdle value)?  idle,TResult Function( AppBootChecking value)?  checking,TResult Function( AppBootOk value)?  ok,TResult Function( AppBootError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AppBootIdle() when idle != null:
return idle(_that);case AppBootChecking() when checking != null:
return checking(_that);case AppBootOk() when ok != null:
return ok(_that);case AppBootError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AppBootIdle value)  idle,required TResult Function( AppBootChecking value)  checking,required TResult Function( AppBootOk value)  ok,required TResult Function( AppBootError value)  error,}){
final _that = this;
switch (_that) {
case AppBootIdle():
return idle(_that);case AppBootChecking():
return checking(_that);case AppBootOk():
return ok(_that);case AppBootError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AppBootIdle value)?  idle,TResult? Function( AppBootChecking value)?  checking,TResult? Function( AppBootOk value)?  ok,TResult? Function( AppBootError value)?  error,}){
final _that = this;
switch (_that) {
case AppBootIdle() when idle != null:
return idle(_that);case AppBootChecking() when checking != null:
return checking(_that);case AppBootOk() when ok != null:
return ok(_that);case AppBootError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  checking,TResult Function()?  ok,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AppBootIdle() when idle != null:
return idle();case AppBootChecking() when checking != null:
return checking();case AppBootOk() when ok != null:
return ok();case AppBootError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  checking,required TResult Function()  ok,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case AppBootIdle():
return idle();case AppBootChecking():
return checking();case AppBootOk():
return ok();case AppBootError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  checking,TResult? Function()?  ok,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case AppBootIdle() when idle != null:
return idle();case AppBootChecking() when checking != null:
return checking();case AppBootOk() when ok != null:
return ok();case AppBootError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class AppBootIdle implements AppBootState {
  const AppBootIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBootIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppBootState.idle()';
}


}




/// @nodoc


class AppBootChecking implements AppBootState {
  const AppBootChecking();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBootChecking);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppBootState.checking()';
}


}




/// @nodoc


class AppBootOk implements AppBootState {
  const AppBootOk();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBootOk);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppBootState.ok()';
}


}




/// @nodoc


class AppBootError implements AppBootState {
  const AppBootError({required this.message});
  

 final  String message;

/// Create a copy of AppBootState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppBootErrorCopyWith<AppBootError> get copyWith => _$AppBootErrorCopyWithImpl<AppBootError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBootError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppBootState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $AppBootErrorCopyWith<$Res> implements $AppBootStateCopyWith<$Res> {
  factory $AppBootErrorCopyWith(AppBootError value, $Res Function(AppBootError) _then) = _$AppBootErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AppBootErrorCopyWithImpl<$Res>
    implements $AppBootErrorCopyWith<$Res> {
  _$AppBootErrorCopyWithImpl(this._self, this._then);

  final AppBootError _self;
  final $Res Function(AppBootError) _then;

/// Create a copy of AppBootState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AppBootError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
