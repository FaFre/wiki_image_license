// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'license.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

License _$LicenseFromJson(Map<String, dynamic> json) {
  return _License.fromJson(json);
}

/// @nodoc
class _$LicenseTearOff {
  const _$LicenseTearOff();

  _License call(
      {required String id,
      required String name,
      required String? url,
      required List<String> groups,
      required List<String> compatibleLicences,
      @RegExpConverter() required RegExp regExp}) {
    return _License(
      id: id,
      name: name,
      url: url,
      groups: groups,
      compatibleLicences: compatibleLicences,
      regExp: regExp,
    );
  }

  License fromJson(Map<String, Object?> json) {
    return License.fromJson(json);
  }
}

/// @nodoc
const $License = _$LicenseTearOff();

/// @nodoc
mixin _$License {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  List<String> get groups => throw _privateConstructorUsedError;
  List<String> get compatibleLicences => throw _privateConstructorUsedError;
  @RegExpConverter()
  RegExp get regExp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LicenseCopyWith<License> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LicenseCopyWith<$Res> {
  factory $LicenseCopyWith(License value, $Res Function(License) then) =
      _$LicenseCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      String? url,
      List<String> groups,
      List<String> compatibleLicences,
      @RegExpConverter() RegExp regExp});
}

/// @nodoc
class _$LicenseCopyWithImpl<$Res> implements $LicenseCopyWith<$Res> {
  _$LicenseCopyWithImpl(this._value, this._then);

  final License _value;
  // ignore: unused_field
  final $Res Function(License) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? groups = freezed,
    Object? compatibleLicences = freezed,
    Object? regExp = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      groups: groups == freezed
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<String>,
      compatibleLicences: compatibleLicences == freezed
          ? _value.compatibleLicences
          : compatibleLicences // ignore: cast_nullable_to_non_nullable
              as List<String>,
      regExp: regExp == freezed
          ? _value.regExp
          : regExp // ignore: cast_nullable_to_non_nullable
              as RegExp,
    ));
  }
}

/// @nodoc
abstract class _$LicenseCopyWith<$Res> implements $LicenseCopyWith<$Res> {
  factory _$LicenseCopyWith(_License value, $Res Function(_License) then) =
      __$LicenseCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      String? url,
      List<String> groups,
      List<String> compatibleLicences,
      @RegExpConverter() RegExp regExp});
}

/// @nodoc
class __$LicenseCopyWithImpl<$Res> extends _$LicenseCopyWithImpl<$Res>
    implements _$LicenseCopyWith<$Res> {
  __$LicenseCopyWithImpl(_License _value, $Res Function(_License) _then)
      : super(_value, (v) => _then(v as _License));

  @override
  _License get _value => super._value as _License;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? url = freezed,
    Object? groups = freezed,
    Object? compatibleLicences = freezed,
    Object? regExp = freezed,
  }) {
    return _then(_License(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      groups: groups == freezed
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<String>,
      compatibleLicences: compatibleLicences == freezed
          ? _value.compatibleLicences
          : compatibleLicences // ignore: cast_nullable_to_non_nullable
              as List<String>,
      regExp: regExp == freezed
          ? _value.regExp
          : regExp // ignore: cast_nullable_to_non_nullable
              as RegExp,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_License extends _License {
  _$_License(
      {required this.id,
      required this.name,
      required this.url,
      required this.groups,
      required this.compatibleLicences,
      @RegExpConverter() required this.regExp})
      : super._();

  factory _$_License.fromJson(Map<String, dynamic> json) =>
      _$$_LicenseFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? url;
  @override
  final List<String> groups;
  @override
  final List<String> compatibleLicences;
  @override
  @RegExpConverter()
  final RegExp regExp;

  @override
  String toString() {
    return 'License(id: $id, name: $name, url: $url, groups: $groups, compatibleLicences: $compatibleLicences, regExp: $regExp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _License &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.groups, groups) &&
            const DeepCollectionEquality()
                .equals(other.compatibleLicences, compatibleLicences) &&
            const DeepCollectionEquality().equals(other.regExp, regExp));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(groups),
      const DeepCollectionEquality().hash(compatibleLicences),
      const DeepCollectionEquality().hash(regExp));

  @JsonKey(ignore: true)
  @override
  _$LicenseCopyWith<_License> get copyWith =>
      __$LicenseCopyWithImpl<_License>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LicenseToJson(this);
  }
}

abstract class _License extends License {
  factory _License(
      {required String id,
      required String name,
      required String? url,
      required List<String> groups,
      required List<String> compatibleLicences,
      @RegExpConverter() required RegExp regExp}) = _$_License;
  _License._() : super._();

  factory _License.fromJson(Map<String, dynamic> json) = _$_License.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get url;
  @override
  List<String> get groups;
  @override
  List<String> get compatibleLicences;
  @override
  @RegExpConverter()
  RegExp get regExp;
  @override
  @JsonKey(ignore: true)
  _$LicenseCopyWith<_License> get copyWith =>
      throw _privateConstructorUsedError;
}
