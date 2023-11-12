import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base_model/api_response.dart';

class ViewAllProductsRepo{
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  ViewAllProductsRepo({required this.dioClient, required this.sharedPreferences});


  /// For get all products data
  Future<ApiResponse> getAllProductsData({dynamic skip, dynamic limit}) async {
    try {
      Response response = await dioClient.get(AppConstants.allProductsUrl,
          // queryParameters: {
          //   'skip': skip.toString(),
          //   'limit': limit.toString(),
          // },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}