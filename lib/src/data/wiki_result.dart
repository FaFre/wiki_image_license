import 'package:wiki_image_license/src/data/image.dart';

class WikiResult {
  final List<Image> images;
  final List<String> unsupportedImages;
  final List<Exception> errors;

  WikiResult(this.images, this.unsupportedImages, this.errors);
}
