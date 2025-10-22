// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reflection_step_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReflectionStepModel {

 String get title; String get description; List<String> get questions; ReflectionStepModel? get prev; ReflectionStepModel? get next;
/// Create a copy of ReflectionStepModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReflectionStepModelCopyWith<ReflectionStepModel> get copyWith => _$ReflectionStepModelCopyWithImpl<ReflectionStepModel>(this as ReflectionStepModel, _$identity);

  /// Serializes this ReflectionStepModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReflectionStepModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.questions, questions)&&(identical(other.prev, prev) || other.prev == prev)&&(identical(other.next, next) || other.next == next));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,const DeepCollectionEquality().hash(questions),prev,next);

@override
String toString() {
  return 'ReflectionStepModel(title: $title, description: $description, questions: $questions, prev: $prev, next: $next)';
}


}

/// @nodoc
abstract mixin class $ReflectionStepModelCopyWith<$Res>  {
  factory $ReflectionStepModelCopyWith(ReflectionStepModel value, $Res Function(ReflectionStepModel) _then) = _$ReflectionStepModelCopyWithImpl;
@useResult
$Res call({
 String title, String description, List<String> questions, ReflectionStepModel? prev, ReflectionStepModel? next
});


$ReflectionStepModelCopyWith<$Res>? get prev;$ReflectionStepModelCopyWith<$Res>? get next;

}
/// @nodoc
class _$ReflectionStepModelCopyWithImpl<$Res>
    implements $ReflectionStepModelCopyWith<$Res> {
  _$ReflectionStepModelCopyWithImpl(this._self, this._then);

  final ReflectionStepModel _self;
  final $Res Function(ReflectionStepModel) _then;

/// Create a copy of ReflectionStepModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? questions = null,Object? prev = freezed,Object? next = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<String>,prev: freezed == prev ? _self.prev : prev // ignore: cast_nullable_to_non_nullable
as ReflectionStepModel?,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as ReflectionStepModel?,
  ));
}
/// Create a copy of ReflectionStepModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReflectionStepModelCopyWith<$Res>? get prev {
    if (_self.prev == null) {
    return null;
  }

  return $ReflectionStepModelCopyWith<$Res>(_self.prev!, (value) {
    return _then(_self.copyWith(prev: value));
  });
}/// Create a copy of ReflectionStepModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReflectionStepModelCopyWith<$Res>? get next {
    if (_self.next == null) {
    return null;
  }

  return $ReflectionStepModelCopyWith<$Res>(_self.next!, (value) {
    return _then(_self.copyWith(next: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReflectionStepModel].
extension ReflectionStepModelPatterns on ReflectionStepModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReflectionStepModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReflectionStepModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReflectionStepModel value)  $default,){
final _that = this;
switch (_that) {
case _ReflectionStepModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReflectionStepModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReflectionStepModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  List<String> questions,  ReflectionStepModel? prev,  ReflectionStepModel? next)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReflectionStepModel() when $default != null:
return $default(_that.title,_that.description,_that.questions,_that.prev,_that.next);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  List<String> questions,  ReflectionStepModel? prev,  ReflectionStepModel? next)  $default,) {final _that = this;
switch (_that) {
case _ReflectionStepModel():
return $default(_that.title,_that.description,_that.questions,_that.prev,_that.next);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  List<String> questions,  ReflectionStepModel? prev,  ReflectionStepModel? next)?  $default,) {final _that = this;
switch (_that) {
case _ReflectionStepModel() when $default != null:
return $default(_that.title,_that.description,_that.questions,_that.prev,_that.next);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReflectionStepModel implements ReflectionStepModel {
  const _ReflectionStepModel({required this.title, required this.description, required final  List<String> questions, this.prev, this.next}): _questions = questions;
  factory _ReflectionStepModel.fromJson(Map<String, dynamic> json) => _$ReflectionStepModelFromJson(json);

@override final  String title;
@override final  String description;
 final  List<String> _questions;
@override List<String> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

@override final  ReflectionStepModel? prev;
@override final  ReflectionStepModel? next;

/// Create a copy of ReflectionStepModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReflectionStepModelCopyWith<_ReflectionStepModel> get copyWith => __$ReflectionStepModelCopyWithImpl<_ReflectionStepModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReflectionStepModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReflectionStepModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.prev, prev) || other.prev == prev)&&(identical(other.next, next) || other.next == next));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,const DeepCollectionEquality().hash(_questions),prev,next);

@override
String toString() {
  return 'ReflectionStepModel(title: $title, description: $description, questions: $questions, prev: $prev, next: $next)';
}


}

/// @nodoc
abstract mixin class _$ReflectionStepModelCopyWith<$Res> implements $ReflectionStepModelCopyWith<$Res> {
  factory _$ReflectionStepModelCopyWith(_ReflectionStepModel value, $Res Function(_ReflectionStepModel) _then) = __$ReflectionStepModelCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, List<String> questions, ReflectionStepModel? prev, ReflectionStepModel? next
});


@override $ReflectionStepModelCopyWith<$Res>? get prev;@override $ReflectionStepModelCopyWith<$Res>? get next;

}
/// @nodoc
class __$ReflectionStepModelCopyWithImpl<$Res>
    implements _$ReflectionStepModelCopyWith<$Res> {
  __$ReflectionStepModelCopyWithImpl(this._self, this._then);

  final _ReflectionStepModel _self;
  final $Res Function(_ReflectionStepModel) _then;

/// Create a copy of ReflectionStepModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? questions = null,Object? prev = freezed,Object? next = freezed,}) {
  return _then(_ReflectionStepModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<String>,prev: freezed == prev ? _self.prev : prev // ignore: cast_nullable_to_non_nullable
as ReflectionStepModel?,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as ReflectionStepModel?,
  ));
}

/// Create a copy of ReflectionStepModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReflectionStepModelCopyWith<$Res>? get prev {
    if (_self.prev == null) {
    return null;
  }

  return $ReflectionStepModelCopyWith<$Res>(_self.prev!, (value) {
    return _then(_self.copyWith(prev: value));
  });
}/// Create a copy of ReflectionStepModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReflectionStepModelCopyWith<$Res>? get next {
    if (_self.next == null) {
    return null;
  }

  return $ReflectionStepModelCopyWith<$Res>(_self.next!, (value) {
    return _then(_self.copyWith(next: value));
  });
}
}

// dart format on
