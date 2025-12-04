// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistics_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StatisticsModel {

 DateTime get date; int get totalReflections; int get totalVictories; List<String> get energyGenerators; List<String> get energyKillers; List<String> get importantToWork; List<String> get fears;
/// Create a copy of StatisticsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticsModelCopyWith<StatisticsModel> get copyWith => _$StatisticsModelCopyWithImpl<StatisticsModel>(this as StatisticsModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticsModel&&(identical(other.date, date) || other.date == date)&&(identical(other.totalReflections, totalReflections) || other.totalReflections == totalReflections)&&(identical(other.totalVictories, totalVictories) || other.totalVictories == totalVictories)&&const DeepCollectionEquality().equals(other.energyGenerators, energyGenerators)&&const DeepCollectionEquality().equals(other.energyKillers, energyKillers)&&const DeepCollectionEquality().equals(other.importantToWork, importantToWork)&&const DeepCollectionEquality().equals(other.fears, fears));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,totalReflections,totalVictories,const DeepCollectionEquality().hash(energyGenerators),const DeepCollectionEquality().hash(energyKillers),const DeepCollectionEquality().hash(importantToWork),const DeepCollectionEquality().hash(fears));

@override
String toString() {
  return 'StatisticsModel(date: $date, totalReflections: $totalReflections, totalVictories: $totalVictories, energyGenerators: $energyGenerators, energyKillers: $energyKillers, importantToWork: $importantToWork, fears: $fears)';
}


}

/// @nodoc
abstract mixin class $StatisticsModelCopyWith<$Res>  {
  factory $StatisticsModelCopyWith(StatisticsModel value, $Res Function(StatisticsModel) _then) = _$StatisticsModelCopyWithImpl;
@useResult
$Res call({
 DateTime date, int totalReflections, int totalVictories, List<String> energyGenerators, List<String> energyKillers, List<String> importantToWork, List<String> fears
});




}
/// @nodoc
class _$StatisticsModelCopyWithImpl<$Res>
    implements $StatisticsModelCopyWith<$Res> {
  _$StatisticsModelCopyWithImpl(this._self, this._then);

  final StatisticsModel _self;
  final $Res Function(StatisticsModel) _then;

/// Create a copy of StatisticsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? totalReflections = null,Object? totalVictories = null,Object? energyGenerators = null,Object? energyKillers = null,Object? importantToWork = null,Object? fears = null,}) {
  return _then(StatisticsModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,totalReflections: null == totalReflections ? _self.totalReflections : totalReflections // ignore: cast_nullable_to_non_nullable
as int,totalVictories: null == totalVictories ? _self.totalVictories : totalVictories // ignore: cast_nullable_to_non_nullable
as int,energyGenerators: null == energyGenerators ? _self.energyGenerators : energyGenerators // ignore: cast_nullable_to_non_nullable
as List<String>,energyKillers: null == energyKillers ? _self.energyKillers : energyKillers // ignore: cast_nullable_to_non_nullable
as List<String>,importantToWork: null == importantToWork ? _self.importantToWork : importantToWork // ignore: cast_nullable_to_non_nullable
as List<String>,fears: null == fears ? _self.fears : fears // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [StatisticsModel].
extension StatisticsModelPatterns on StatisticsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
