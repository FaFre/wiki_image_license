import 'package:html/dom.dart';

class Asset {
  final Document dom;

  static final urlPattern = RegExp(r'^\/w\/index\.php\?title\=([^&]+).*$');
  static final whitespacePattern = RegExp(r'\s+');

  Asset(this.dom);

  static void _sanitizeUrls(Element node) {
    for (final node in node.querySelectorAll('a')) {
      var href = node.attributes['href'];

      if (href != null) {
        if (href.startsWith('/w/index.php?title=User:')) {
          href = href.replaceAllMapped(
              urlPattern,
              (match) =>
                  'https://commons.wikimedia.org/wiki/${match.group(1)}');
        } else if (href.startsWith('/wiki/User:')) {
          href = 'https://commons.wikimedia.org' + href;
        } else if (href.startsWith('//')) {
          href = 'https:' + href;
        }

        node.attributes['href'] = href;
        node.attributes.removeWhere((key, value) => key != 'href');
      }
    }
  }

  static void _flattenVCard(Element node) {
    for (final vcard in node.querySelectorAll('div.vcard')) {
      for (final creator in vcard.querySelectorAll('span#creator')) {
        vcard.innerHtml = creator.innerHtml;
      }
    }
  }

  static void _removeUnwantedHtmlTags(Document dom, Element node) {
    for (final node in node.querySelectorAll('*:not(a)')) {
      node.reparentChildren(node.parentNode ?? dom);
      node.remove();
    }
  }

  static void _removeUnwantedWhiteSpaces(Element node) {
    node.innerHtml = node.innerHtml
        .replaceAll('&nbsp;', ' ')
        .replaceAll(whitespacePattern, ' ')
        .trim();
  }

  static void _trimNodeList(Element node) {
    if (node.nodes.first.text?.trim() == '') {
      node.nodes.first.remove();
    }

    while (node.nodes.last.text?.trim() == '') {
      node.nodes.last.remove();
    }
  }

  static Element _scrapeSummaryField(Document dom, Element node) {
    _sanitizeUrls(node);
    _flattenVCard(node);

    //Unwrap child nodes
    if (node.nodes.length == 1) {
      if (node.nodes.first is! Text &&
          !(node.nodes.first is Element &&
              (node.nodes.first as Element).localName == 'a')) {
        node.reparentChildren(node.parentNode ?? dom);
        node.remove();
      }
    }

    //Remove talk links
    for (var i = 0; i < node.nodes.length; i++) {
      final currentNode = node.nodes[i];
      if (currentNode is Element) {
        if (currentNode.localName == 'a' && currentNode.text == 'talk') {
          node.nodes.retainWhere((testNode) => !(testNode == node.nodes[i] ||
              testNode == node.nodes[i - 1] ||
              testNode == node.nodes[i + 1]));
        }
      }
    }

    _removeUnwantedHtmlTags(dom, node);
    _removeUnwantedWhiteSpaces(node);
    _trimNodeList(node);

    return node;
  }

  Element? getAttribution() {
    final clonedDom = dom.clone(true);
    final licenseTpl = clonedDom.querySelector('.licensetpl_attr');

    if (licenseTpl != null) {
      //unwrap
      if (licenseTpl.children.length == 1) {
        final contents = licenseTpl.children.first;
        contents.reparentChildren(contents.parentNode!);
        contents.remove();
      }

      _sanitizeUrls(licenseTpl);
      _trimNodeList(licenseTpl);

      return licenseTpl;
    } else {
      //unvalidated!!

      final attributionNode = clonedDom
          .querySelector('.commons-file-information-table td:first-child')
          ?.children
          .where((element) => element.text.contains('Attribution'));

      final attribution = (attributionNode?.isNotEmpty ?? false)
          ? attributionNode!.first.nextElementSibling
          : null;

      if (attribution != null) {
        return _scrapeSummaryField(clonedDom, attribution);
      }
    }

    return null;
  }

  Element? getAuthor() {
    final clonedDom = dom.clone(true);
    var author =
        clonedDom.getElementById('fileinfotpl_aut')?.nextElementSibling;

    if (author != null) {
      return _scrapeSummaryField(clonedDom, author);
    }
  }
}
