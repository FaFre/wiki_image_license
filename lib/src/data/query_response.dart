class QueryResponse {
  final Map<String, dynamic> validPages;
  final List<Exception> errors;

  bool get allSuccessful => errors.isEmpty && validPages.isNotEmpty;

  const QueryResponse(this.validPages, this.errors);
}
