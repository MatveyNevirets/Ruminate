// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_reflect_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyReflectModel {

 String get id; ReflectType get type; Map<String, String> get fields;
/// Create a copy of DailyReflectModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyReflectModelCopyWith<DailyReflectModel> get copyWith => _$DailyReflectModelCopyWithImpl<DailyReflectModel>(this as DailyReflectModel, _$identity);

  /// Serializes this DailyReflectModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyReflectModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.fields, fields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,const DeepCollectionEquality().hash(fields));

@override
String toString() {
  return 'DailyReflectModel(id: $id, type: $type, fields: $fields)';
}


}

/// @nodoc
abstract mixin class $DailyReflectModelCopyWith<$Res>  {
  factory $DailyReflectModelCopyWith(DailyReflectModel value, $Res Function(DailyReflectModel) _then) = _$DailyReflectModelCopyWithImpl;
@useResult
$Res call({
 String id, ReflectType type, Map<String, String> fields
});




}
/// @nodoc
class _$DailyReflectModelCopyWithImpl<$Res>
    implements $DailyReflectModelCopyWith<$Res> {
  _$DailyReflectModelCopyWithImpl(this._self, this._then);

  final DailyReflectModel _self;
  final $Res Function(DailyReflectModel) _then;

/// Create a copy of DailyReflectModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? fields = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReflectType,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyReflectModel].
extension DailyReflectModelPatterns on DailyReflectModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyReflectModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyReflectModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyReflectModel value)  $default,){
final _that = this;
switch (_that) {
case _DailyReflectModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyReflectModel value)?  $default,){
final _that = this;
switch (_that) {
case _DailyReflectModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ReflectType type,  Map<String, String> fields)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyReflectModel() when $default != null:
return $default(_that.id,_that.type,_that.fields);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ReflectType type,  Map<String, String> fields)  $default,) {final _that = this;
switch (_that) {
case _DailyReflectModel():
return $default(_that.id,_that.type,_that.fields);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ReflectType type,  Map<String, String> fields)?  $default,) {final _that = this;
switch (_that) {
case _DailyReflectModel() when $default != null:
return $default(_that.id,_that.type,_that.fields);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyReflectModel implements DailyReflectModel {
  const _DailyReflectModel({required this.id, required this.type, required final  Map<String, String> fields}): _fields = fields;
  factory _DailyReflectModel.fromJson(Map<String, dynamic> json) => _$DailyReflectModelFromJson(json);

@override final  String id;
@override final  ReflectType type;
 final  Map<String, String> _fields;
@override Map<String, String> get fields {
  if (_fields is EqualUnmodifiableMapView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fields);
}


/// Create a copy of DailyReflectModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyReflectModelCopyWith<_DailyReflectModel> get copyWith => __$DailyReflectModelCopyWithImpl<_DailyReflectModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyReflectModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyReflectModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._fields, _fields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,const DeepCollectionEquality().hash(_fields));

@override
String toString() {
  return 'DailyReflectModel(id: $id, type: $type, fields: $fields)';
}


}

/// @nodoc
abstract mixin class _$DailyReflectModelCopyWith<$Res> implements $DailyReflectModelCopyWith<$Res> {
  factory _$DailyReflectModelCopyWith(_DailyReflectModel value, $Res Function(_DailyReflectModel) _then) = __$DailyReflectModelCopyWithImpl;
@override @useResult
$Res call({
 String id, ReflectType type, Map<String, String> fields
});




}
/// @nodoc
class __$DailyReflectModelCopyWithImpl<$Res>
    implements _$DailyReflectModelCopyWith<$Res> {
  __$DailyReflectModelCopyWithImpl(this._self, this._then);

  final _DailyReflectModel _self;
  final $Res Function(_DailyReflectModel) _then;

/// Create a copy of DailyReflectModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? fields = null,}) {
  return _then(_DailyReflectModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReflectType,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
