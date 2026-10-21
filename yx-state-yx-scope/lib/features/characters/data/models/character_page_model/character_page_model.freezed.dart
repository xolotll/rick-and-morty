// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CharacterPageModel {

 List<CharacterModel> get characters; String? get nextUrl;
/// Create a copy of CharacterPageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CharacterPageModelCopyWith<CharacterPageModel> get copyWith => _$CharacterPageModelCopyWithImpl<CharacterPageModel>(this as CharacterPageModel, _$identity);

  /// Serializes this CharacterPageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CharacterPageModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharacterPageModel&&const DeepCollectionEquality().equals(other.characters, _this.characters)&&(identical(other.nextUrl, _this.nextUrl) || other.nextUrl == _this.nextUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CharacterPageModel;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.characters),_this.nextUrl);
}

@override
String toString() {
  final _this = this as CharacterPageModel;
  return 'CharacterPageModel(characters: ${_this.characters}, nextUrl: ${_this.nextUrl})';
}


}

/// @nodoc
abstract mixin class $CharacterPageModelCopyWith<$Res>  {
  factory $CharacterPageModelCopyWith(CharacterPageModel value, $Res Function(CharacterPageModel) _then) = _$CharacterPageModelCopyWithImpl;
@useResult
$Res call({
 List<CharacterModel> characters, String? nextUrl
});




}
/// @nodoc
class _$CharacterPageModelCopyWithImpl<$Res>
    implements $CharacterPageModelCopyWith<$Res> {
  _$CharacterPageModelCopyWithImpl(this._self, this._then);

  final CharacterPageModel _self;
  final $Res Function(CharacterPageModel) _then;

/// Create a copy of CharacterPageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? characters = null,Object? nextUrl = freezed,}) {
  return _then(CharacterPageModel(
characters: null == characters ? _self.characters : characters // ignore: cast_nullable_to_non_nullable
as List<CharacterModel>,nextUrl: freezed == nextUrl ? _self.nextUrl : nextUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CharacterPageModel].
extension CharacterPageModelPatterns on CharacterPageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CharacterPageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CharacterPageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CharacterPageModel value)  $default,){
final _that = this;
switch (_that) {
case _CharacterPageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CharacterPageModel value)?  $default,){
final _that = this;
switch (_that) {
case _CharacterPageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CharacterModel> characters,  String? nextUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CharacterPageModel() when $default != null:
return $default(_that.characters,_that.nextUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CharacterModel> characters,  String? nextUrl)  $default,) {final _that = this;
switch (_that) {
case _CharacterPageModel():
return $default(_that.characters,_that.nextUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CharacterModel> characters,  String? nextUrl)?  $default,) {final _that = this;
switch (_that) {
case _CharacterPageModel() when $default != null:
return $default(_that.characters,_that.nextUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CharacterPageModel extends CharacterPageModel {
  const _CharacterPageModel({ List<CharacterModel> characters = const <CharacterModel>[], this.nextUrl}): _characters = characters,super._();
  factory _CharacterPageModel.fromJson(Map<String, dynamic> json) => _$CharacterPageModelFromJson(json);

 final  List<CharacterModel> _characters;
@override@JsonKey() List<CharacterModel> get characters {
  if (_characters is EqualUnmodifiableListView) return _characters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_characters);
}

@override final  String? nextUrl;

/// Create a copy of CharacterPageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CharacterPageModelCopyWith<_CharacterPageModel> get copyWith => __$CharacterPageModelCopyWithImpl<_CharacterPageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CharacterPageModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CharacterPageModel&&const DeepCollectionEquality().equals(other.characters, _characters)&&(identical(other.nextUrl, nextUrl) || other.nextUrl == nextUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_characters),nextUrl);
}

@override
String toString() {
    return 'CharacterPageModel(characters: $characters, nextUrl: $nextUrl)';
}


}

/// @nodoc
abstract mixin class _$CharacterPageModelCopyWith<$Res> implements $CharacterPageModelCopyWith<$Res> {
  factory _$CharacterPageModelCopyWith(_CharacterPageModel value, $Res Function(_CharacterPageModel) _then) = __$CharacterPageModelCopyWithImpl;
@override @useResult
$Res call({
 List<CharacterModel> characters, String? nextUrl
});




}
/// @nodoc
class __$CharacterPageModelCopyWithImpl<$Res>
    implements _$CharacterPageModelCopyWith<$Res> {
  __$CharacterPageModelCopyWithImpl(this._self, this._then);

  final _CharacterPageModel _self;
  final $Res Function(_CharacterPageModel) _then;

/// Create a copy of CharacterPageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? characters = null,Object? nextUrl = freezed,}) {
  return _then(_CharacterPageModel(
characters: null == characters ? _self._characters : characters // ignore: cast_nullable_to_non_nullable
as List<CharacterModel>,nextUrl: freezed == nextUrl ? _self.nextUrl : nextUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
