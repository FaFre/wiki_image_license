// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'license.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_License _$$_LicenseFromJson(Map<String, dynamic> json) => _$_License(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String?,
      groups:
          (json['groups'] as List<dynamic>).map((e) => e as String).toList(),
      compatibleLicences: (json['compatibleLicences'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      regExp: const RegExpConverter().fromJson(json['regExp'] as String),
    );

Map<String, dynamic> _$$_LicenseToJson(_$_License instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'groups': instance.groups,
      'compatibleLicences': instance.compatibleLicences,
      'regExp': const RegExpConverter().toJson(instance.regExp),
    };
