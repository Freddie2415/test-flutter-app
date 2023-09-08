class ApiException implements Exception {
  final String message;

  ApiException(this.message);
}

class NoInternetException implements ApiException {
  @override
  final String message;

  NoInternetException(this.message);

  @override
  String toString() => 'NoInternetException: $message';
}

class ServerErrorException implements ApiException {
  final int statusCode;
  @override
  final String message;

  ServerErrorException(this.statusCode, this.message);

  @override
  String toString() => 'ServerErrorException: $statusCode - $message';
}

class RequestErrorException implements ApiException {
  @override
  final String message;

  RequestErrorException(this.message);

  @override
  String toString() => 'RequestErrorException: $message';
}
