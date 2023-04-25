import 'package:dio/dio.dart';
import 'package:new_pokemon_app/core/errors/exception.dart';

enum RequestType { get }

const successCode = [200, 201];

class HttpManager {
  final Dio dio;
  final ServerException Function(Response<dynamic>? data)? errorResponseMapper;
  HttpManager({
    required this.dio,
    this.errorResponseMapper,
  }) {
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
  }

  Future get(String endpoint) =>
      _futureNetworkRequest(RequestType.get, endpoint, {});

  Future _futureNetworkRequest(
    RequestType type,
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      late Response response;
      switch (type) {
        case RequestType.get:
          response = await dio.get(endpoint);
          break;
        default:
          throw InvalidArgOrDataException();
      }
      if (successCode.contains(response.statusCode)) {
        return response.data;
      }
      throw errorResponseMapper?.call(response) ??
          serverErrorResponseMapper(response);
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      if (e is DioError) {
        if (e.type == DioErrorType.connectTimeout ||
            e.type == DioErrorType.receiveTimeout) {
          throw TimeoutServerException();
        }
        if (e is FormatException) {
          throw InvalidArgOrDataException();
        }
        if (e.response?.data != null) {
          throw errorResponseMapper?.call(e.response) ??
              serverErrorResponseMapper(e.response);
        }
      }
      throw UnexpectedServerException();
    }
  }
}

ServerException serverErrorResponseMapper(Response<dynamic>? response) {
  final data = response?.data;
  if (data is Map) {
    if (data['message'] != null) return PokeAppServerException(data['message']);
    if (data['error'] != null) return PokeAppServerException(data['error']);
  }
  return UnexpectedServerException();
}
