import 'package:html/dom.dart';
import 'package:wiki_image_license/src/data/license.dart';

class Image {
  final int pageId;
  final String title;
  final License license;
  final Element? attribution;
  final String url;
  final String imageTitle;
  final bool titleRequiredByLicense;
  final dynamic queryData;

  const Image(
      {required this.pageId,
      required this.title,
      required this.license,
      required this.attribution,
      required this.url,
      required this.imageTitle,
      required this.titleRequiredByLicense,
      required this.queryData});
}
