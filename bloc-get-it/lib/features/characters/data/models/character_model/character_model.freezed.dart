// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CharacterModel {

 int get id; String get name; String get status; String get species; String get type; String get gender;@JsonKey(defaultValue: 'Unknown', readValue: _readNestedName) String get origin;@JsonKey(defaultValue: 'Unknown', readValue: _readNestedName) String get location; String get image;
/// Create a copy of CharacterModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CharacterModelCopyWith<CharacterModel> get copyWith => _$CharacterModelCopyWithImpl<CharacterModel>(this as CharacterModel, _$identity);

  /// Serializes this CharacterModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CharacterModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharacterModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.species, _this.species) || other.species == _this.species)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.gender, _this.gender) || other.gender == _this.gender)&&(identical(other.origin, _this.origin) || other.origin == _this.origin)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.image, _this.image) || other.image == _this.image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CharacterModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.status,_this.species,_this.type,_this.gender,_this.origin,_this.location,_this.image);
}

@override
String toString() {
  final _this = this as CharacterModel;
  return 'CharacterModel(id: ${_this.id}, name: ${_this.name}, status: ${_this.status}, species: ${_this.species}, type: ${_this.type}, gender: ${_this.gender}, origin: ${_this.origin}, location: ${_this.location}, image: ${_this.image})';
}


}

/// @nodoc
abstract mixin class $CharacterModelCopyWith<$Res>  {
  factory $CharacterModelCopyWith(CharacterModel value, $Res Function(CharacterModel) _then) = _$CharacterModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String status, String species, String type, String gender,@JsonKey(defaultValue: 'Unknown', readValue: _readNestedName) String origin,@JsonKey(defaultValue: 'Unknown', readValue: _readNestedName) String location, String image
});




}
/// @nodoc
class _$CharacterModelCopyWithImpl<$Res>
    implements $CharacterModelCopyWith<$Res> {
  _$CharacterModelCopyWithImpl(this._self, this._then);

  final CharacterModel _self;
  final $Res Function(CharacterModel) _then;

/// Create a copy of CharacterModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? status = null,Object? species = null,Object? type = null,Object? gender = null,Object? origin = null,Object? location = null,Object? image = null,}) {
  return _then(CharacterModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CharacterModel].
extension CharacterModelPatterns on CharacterModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CharacterModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CharacterModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CharacterModel value)  $default,){
final _that = this;
switch (_that) {
case _CharacterModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CharacterModel value)?  $default,){
final _that = this;
switch (_that) {
case _CharacterModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String status,  String species,  String type,  String gender, @JsonKey(defaultValue: 'Unknown', readValue: _readNestedName)  String origin, @JsonKey(defaultValue: 'Unknown', readValue: _readNestedName)  String location,  String image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CharacterModel() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.species,_that.type,_that.gender,_that.origin,_that.location,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String status,  String species,  String type,  String gender, @JsonKey(defaultValue: 'Unknown', readValue: _readNestedName)  String origin, @JsonKey(defaultValue: 'Unknown', readValue: _readNestedName)  String location,  String image)  $default,) {final _that = this;
switch (_that) {
case _CharacterModel():
return $default(_that.id,_that.name,_that.status,_that.species,_that.type,_that.gender,_that.origin,_that.location,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String status,  String species,  String type,  String gender, @JsonKey(defaultValue: 'Unknown', readValue: _readNestedName)  String origin, @JsonKey(defaultValue: 'Unknown', readValue: _readNestedName)  String location,  String image)?  $default,) {final _that = this;
switch (_that) {
case _CharacterModel() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.species,_that.type,_that.gender,_that.origin,_that.location,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CharacterModel extends CharacterModel {
  const _CharacterModel({this.id = 0, this.name = 'Unknown', this.status = 'unknown', this.species = 'Unknown', this.type = '', this.gender = 'Unknown', @JsonKey(defaultValue: 'Unknown', readValue: _readNestedName) this.origin = 'Unknown', @JsonKey(defaultValue: 'Unknown', readValue: _readNestedName) this.location = 'Unknown', this.image = ''}): super._();
  factory _CharacterModel.fromJson(Map<String, dynamic> json) => _$CharacterModelFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String status;
@override@JsonKey() final  String species;
@override@JsonKey() final  String type;
@override@JsonKey() final  String gender;
@override@JsonKey(defaultValue: 'Unknown', readValue: _readNestedName) final  String origin;
@override@JsonKey(defaultValue: 'Unknown', readValue: _readNestedName) final  String location;
@override@JsonKey() final  String image;

/// Create a copy of CharacterModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CharacterModelCopyWith<_CharacterModel> get copyWith => __$CharacterModelCopyWithImpl<_CharacterModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CharacterModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CharacterModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.species, species) || other.species == species)&&(identical(other.type, type) || other.type == type)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.location, location) || other.location == location)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,status,species,type,gender,origin,location,image);
}

@override
String toString() {
    return 'CharacterModel(id: $id, name: $name, status: $status, species: $species, type: $type, gender: $gender, origin: $origin, location: $location, image: $image)';
}


}

/// @nodoc
abstract mixin class _$CharacterModelCopyWith<$Res> implements $CharacterModelCopyWith<$Res> {
  factory _$CharacterModelCopyWith(_CharacterModel value, $Res Function(_CharacterModel) _then) = __$CharacterModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String status, String species, String type, String gender,@JsonKey(defaultValue: 'Unknown', readValue: _readNestedName) String origin,@JsonKey(defaultValue: 'Unknown', readValue: _readNestedName) String location, String image
});




}
/// @nodoc
class __$CharacterModelCopyWithImpl<$Res>
    implements _$CharacterModelCopyWith<$Res> {
  __$CharacterModelCopyWithImpl(this._self, this._then);

  final _CharacterModel _self;
  final $Res Function(_CharacterModel) _then;

/// Create a copy of CharacterModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? status = null,Object? species = null,Object? type = null,Object? gender = null,Object? origin = null,Object? location = null,Object? image = null,}) {
  return _then(_CharacterModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
