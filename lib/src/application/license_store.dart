import 'dart:convert';

import 'package:wiki_image_license/src/data/license.dart';
import 'package:wiki_image_license/src/data/license_data.dart' as json_data;

class LicenseStore {
  List<License> licenses;
  Map<String, String> portedLicenses;

  static final _cachedDefaultInstance =
      LicenseStore.fromJson(json_data.licenseJson, json_data.portedLicenses);

  LicenseStore(this.licenses, this.portedLicenses);

  factory LicenseStore.fromJson(
      String licensesJson, String portedLicensesJson) {
    final licenses = (jsonDecode(licensesJson) as List<dynamic>)
        .map((license) => License.fromJson(license))
        .toList(growable: false);

    final portedLicenses =
        Map<String, String>.from(jsonDecode(portedLicensesJson));

    return LicenseStore(licenses, portedLicenses);
  }

  factory LicenseStore.defaultLicenses() {
    return _cachedDefaultInstance;
  }

  License? detectLicense(List<String> templates) {
    final detectedLicenses = <License>[];

    for (final template in templates) {
      detectedLicenses.addAll(licenses
          .where((license) => license.regExp.hasMatch(template))
          .map((license) => (license.groups.contains('ported') &&
                  portedLicenses.containsKey(template))
              ? license.copyWith(
                  regExp: RegExp('^' + license.id, caseSensitive: false),
                  name: template
                      .toUpperCase()
                      .split('-')
                      .join(' ')
                      .replaceAll('BY SA', 'BY-SA'),
                  groups: [...license.groups],
                  compatibleLicences: [],
                  url: portedLicenses[template])
              : license));
    }

    if (detectedLicenses.isNotEmpty) {
      //Return first matching in order
      return licenses.firstWhere(
          (license) => detectedLicenses.any((match) => match.id == license.id));
    }

    return null;
  }
}
