class QueryRequest {
  final List<String> props;
  final Map<String, dynamic> parameters;
  final List<String>? titles;
  final List<int>? pageIds;
  final bool suppressImageProblems;

  const QueryRequest(
      {required this.props,
      required this.parameters,
      this.titles,
      this.pageIds,
      this.suppressImageProblems = true})
      : assert((titles != null) ^ (pageIds != null),
            'Either a list of titles or pageids must be provided');

  Map<String, dynamic> getParams() {
    final params = {
      'action': 'query',
      'format': 'json',
      if (titles != null) 'titles': titles!.join('|'),
      if (pageIds != null)
        'pageids': pageIds!.map((e) => e.toString()).join('|'),
      'prop': props.join('|'),
      ...parameters
    };

    return params;
  }
}
