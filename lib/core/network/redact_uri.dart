const sensitiveQueryKeys = <String>{
  'authorization',
  'access_token',
  'code',
  'password',
  'refresh_token',
  'secret',
  'token',
};

String redactUri(Uri uri) {
  if (uri.queryParameters.isEmpty) {
    return uri.toString();
  }

  final filtered = <String, String>{};
  for (final entry in uri.queryParameters.entries) {
    if (sensitiveQueryKeys.contains(entry.key.toLowerCase())) {
      continue;
    }
    filtered[entry.key] = entry.value;
  }
  return uri.replace(queryParameters: filtered).toString();
}
