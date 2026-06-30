import 'package:dio/dio.dart';

class RequestException implements Exception {
  String? message;

  RequestException.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = 'Request to API server was cancelled';
        break;
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout with API server';
        break;
      case DioExceptionType.connectionError:
        message = 'Connection to API server failed due to internet connection';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Received timeout in connection with API server';
        break;
      case DioExceptionType.badResponse:
        message = _handeError(dioError.response!.statusCode ?? 500);
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout in connection with API server';
        break;
      default:
        message = 'Aplikasi sedang gangguan, coba lagi nanti.';
        break;
    }
  }

  String _handeError(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request';
      case 404:
        return 'The requested resources was not found';
      case 500:
        return 'Internal Server Error';
      default:
        return 'Internal Server Error';
    }
  }

  @override
  String toString() => message.toString();
}
