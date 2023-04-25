abstract class PokeAppException implements Exception {
  String get message;

  @override
  operator ==(other) {
    return other is PokeAppException && message == other.message;
  }

  @override
  int get hashCode => message.hashCode;
}

abstract class ServerException implements PokeAppException {}

class TimeoutServerException implements ServerException {
  final String msg;
  TimeoutServerException([this.msg = 'Connection Timeout']);

  @override
  String get message => msg;
}

class UnexpectedServerException implements ServerException {
  final String msg;
  UnexpectedServerException([this.msg = 'An unexpected error occured']);

  @override
  String get message => msg;
}

class PokeAppServerException implements ServerException {
  final String msg;
  PokeAppServerException([this.msg = 'An unexpected error occured']);

  @override
  String get message => msg;
}

class InvalidArgOrDataException implements PokeAppException {
  final String msg;
  InvalidArgOrDataException([this.msg = "Error in arguments or data"]);

  @override
  String get message => msg;
}

class CacheGetException implements PokeAppException {
  final String msg;
  CacheGetException([this.msg = "Rrror retrieving data from cache"]);

  @override
  String get message => msg;
}

class CachePutException implements PokeAppException {
  final String msg;
  CachePutException([this.msg = "Error saving data to cache"]);

  @override
  String get message => msg;
}
