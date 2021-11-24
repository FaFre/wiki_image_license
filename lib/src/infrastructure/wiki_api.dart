import 'dart:convert';

import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:wiki_image_license/src/application/asset.dart';
import 'package:wiki_image_license/src/application/license_store.dart';
import 'package:wiki_image_license/src/data/image.dart';
import 'package:wiki_image_license/src/data/query_request.dart';
import 'package:wiki_image_license/src/data/query_response.dart';
import 'package:wiki_image_license/src/data/wiki_result.dart';

typedef Json = Map<String, dynamic>;

class WikiApi {
  /// https://commons.wikimedia.org/
  final Uri wikiBaseUri;

  late LicenseStore licenseStore;
  late http.Client httpClient;

  static const defaultQueryParams = {
    'rvprop': 'content',
    'rvparse': '1',
    'tlnamespace': '10',
    'tllimit': '100',
    'iiprop': 'mediatype|url',
    'iilimit': '1'
  };

  WikiApi(
      {required this.wikiBaseUri,
      LicenseStore? licenseStore,
      http.Client? httpClient})
      : httpClient = httpClient ?? http.Client(),
        licenseStore = licenseStore ?? LicenseStore.defaultLicenses();

  Future<QueryResponse> _query(QueryRequest params) async {
    final requestUri = wikiBaseUri.replace(
        path: '/w/api.php', queryParameters: params.getParams());
    final result = await httpClient.get(requestUri);

    if (result.statusCode != 200) {
      throw http.ClientException(
          'Request was unsuccessful code ${result.statusCode}', requestUri);
    }

    final response = jsonDecode(result.body) as Json;

    final pages = response['query']?['pages'] as Json?;
    if (pages == null) {
      throw http.ClientException('Invalid query response', requestUri);
    }

    final errors = <Exception>[];
    final validPages = <dynamic>[];

    for (final page in pages.values) {
      final shared = params.props.contains('imageinfo') &&
          page['imagerepository'] == 'shared';

      if (page['missing'] != null && !shared) {
        errors.add(Exception('Url invalid for $page'));
      } else if (page['invalid'] != null) {
        errors.add(Exception('Page invalid for $page'));
      } else {
        validPages.add(page);
      }
    }

    final queryResponse = QueryResponse(
        Map.fromEntries(
            validPages.map((page) => MapEntry(page['title'], page))),
        errors);

    if (!params.suppressImageProblems && !queryResponse.allSuccessful) {
      throw Exception(queryResponse.errors);
    }

    return queryResponse;
  }

  Json getImageinfo(Json value) => value['imageinfo'].first;

  Document getRevisions(Json value) => parse(value['revisions'].first['*']);

  List<String> getTemplates(Json value) => (value['templates'] as List<dynamic>)
      .cast<Map<String, dynamic>>()
      .map((template) =>
          (template['title'] as String).replaceAll(RegExp(r'^[^:]+:'), ''))
      .toList(growable: false);

  Future<WikiResult> getLicenses(
      {List<String>? titles,
      List<int>? pageIds,
      List<String> props = const ['imageinfo', 'revisions', 'templates'],
      Map<String, dynamic> queryParams = defaultQueryParams}) async {
    assert((titles != null) ^ (pageIds != null),
        'Either a list of titles or pageids must be provided');

    final response = await _query(QueryRequest(
        props: props,
        pageIds: pageIds,
        titles: titles,
        parameters: queryParams));

    final result = WikiResult([], [], response.errors);

    for (final page in response.validPages.entries) {
      final imageinfo = getImageinfo(page.value);
      final revisions = getRevisions(page.value);
      final templates = getTemplates(page.value);

      final asset = Asset(revisions);

      final license = licenseStore.detectLicense(templates);
      if (license == null || license.groups.contains('unsupported')) {
        result.unsupportedImages.add(page.key);
        continue;
      }

      final attribution = asset.getAttribution() ?? asset.getAuthor();
      if (attribution == null && !license.isPublicDomain) {
        result.unsupportedImages.add(page.key);
        continue;
      }

      final url = (imageinfo['descriptionurl'] as String?) ??
          '${wikiBaseUri}wiki/${page.key}';
      final imageTitle = page.key
          .replaceFirst(RegExp(r'^[^:]+:'), '')
          .replaceFirst(RegExp(r'\.[^.]+$'), '')
          .replaceAll('_', ' ');

      final titleRequiredByLicense = !(license.groups.contains('cc4'));

      result.images.add(Image(
          pageId: page.value['pageid'] as int,
          title: page.key,
          license: license,
          attribution: attribution,
          url: url,
          imageTitle: imageTitle,
          titleRequiredByLicense: titleRequiredByLicense,
          queryData: page.value));
    }

    return result;
  }
}
