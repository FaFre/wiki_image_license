import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wiki_image_license/src/data/license_data.dart';

part 'license.freezed.dart';
part 'license.g.dart';

class RegExpConverter implements JsonConverter<RegExp, String> {
  const RegExpConverter();

  static final jsNotationPattern = RegExp(r'^\/(.*?)\/([a-z]*)$');

  @override
  RegExp fromJson(String rawRegex) {
    final regex = jsNotationPattern.firstMatch(rawRegex);
    if (regex == null) {
      throw Exception('Could not parse regex from js notation');
    }

    final flags = regex.group(2)!;

    return RegExp(regex.group(1)!,
        caseSensitive: !flags.contains('i'),
        multiLine: flags.contains('m'),
        unicode: flags.contains('u'),
        dotAll: flags.contains('s'));
  }

  @override
  String toJson(RegExp object) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

@freezed
class License with _$License {
  const License._();

  factory License(
      {required String id,
      required String name,
      required String? url,
      required List<String> groups,
      required List<String> compatibleLicences,
      @RegExpConverter() required RegExp regExp}) = _License;

  factory License.fromJson(Map<String, dynamic> json) =>
      _$LicenseFromJson(json);

  bool get isPublicDomain => groups.contains('pd');
}
