import 'package:dio/dio.dart';
import '../../../model/base_model/error_response.dart';


class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              errorDescription = "Request to server was cancelled";
              break;
            case DioErrorType.connectTimeout:
              errorDescription = "Connection timeout with server";
              break;
            case DioErrorType.other:
              errorDescription =
              "Connection to server failed due to internet connection ";//${DioErrorType.other.name}
              break;
            case DioErrorType.receiveTimeout:
              errorDescription =
              "Receive timeout in connection with server";
              break;
            case DioErrorType.response:
              switch (error.response!.statusCode) {
                case 404:
                case 500:
                case 503:
                  errorDescription = error.response!.statusMessage;
                  break;
                default:
                  ErrorResponse errorResponse =
                  ErrorResponse.fromJson(error.response!.data);
                  // if (errorResponse.error != null &&
                  //     errorResponse.error. > 0)
                  if (errorResponse.error != null)
                    errorDescription = errorResponse;
                  else
                    errorDescription = "Failed to load data - status code: ${error.response!.statusCode}";
              }
              break;
            case DioErrorType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;
          }
        } else {
          errorDescription = "Unexpected error occurred";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}
