import 'dart:convert';

import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:wiki_image_license/src/data/license.dart';
import 'package:wiki_image_license/src/infrastructure/wiki_api.dart';

void main() {
  test('license regex parse', () {
    var license = License.fromJson(jsonDecode(r'''{
        "id": "cc-by-2.5-ported",
        "groups": [
            "cc",
            "cc2.5",
            "ccby",
            "ported"
        ],
        "compatibleLicences": [],
        "name": "CC BY 2.5",
        "regExp": "/^CC-BY-2.5-\\w+$/i",
        "url": "https://creativecommons.org/licenses/by/2.5/legalcode"
    }'''));

    expect(license.regExp.isCaseSensitive, isFalse);
    expect(license.regExp.hasMatch('Cc-by-2.5-au'), isTrue);
    expect(license.regExp.hasMatch('Cc-by-2.6-au'), isFalse);
  });

  // test('license load', () {
  //   expect(licenses, isNotEmpty);
  //   expect(portedLicenses, isNotEmpty);
  // });

  test('html test', () async {
    final api =
        WikiApi(wikiBaseUri: Uri.parse('https://commons.wikimedia.org/'));

    final y = await api.getLicenses(pageIds: [20335334]);
    print(y);
    // final x = await api.queryRevisions(QueryParameters.revisions({
    //   'rvprop': 'content',
    //   'rvparse': '1',
    //   'titles': 'File:13-09-29-nordfriesisches-wattenmeer-RalfR-15.jpg'
    // }) as RevisionsParams);

    // final asset = Asset(x.first).getAuthor();
    // print(asset!.text);
  });
}
