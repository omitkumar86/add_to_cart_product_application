import 'package:add_to_cart_product_application/provider/cart_provider.dart';
import 'package:add_to_cart_product_application/provider/product_details_provider.dart';
import 'package:add_to_cart_product_application/provider/view_all_products_provider.dart';
import 'package:add_to_cart_product_application/utils/constants/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/repositories/view_all_products_repo.dart';


final sl = GetIt.instance;

Future<void> init() async {

  /// Core
     sl.registerLazySingleton(() => DioClient(AppConstants.baseUrl, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  /// Repository
     sl.registerLazySingleton(() => ViewAllProductsRepo(dioClient: sl(), sharedPreferences: sl()));

  /// Provider
     sl.registerFactory(() => ViewAllProductsProvider(dioClient: sl(), viewAllProductsRepo: sl()));
     sl.registerFactory(() => CartProvider());
     sl.registerFactory(() => ProductDetailsProvider());

  /// External
      final sharedPreferences = await SharedPreferences.getInstance();
      sl.registerLazySingleton(() => sharedPreferences);
      sl.registerLazySingleton(() => Dio());
      sl.registerLazySingleton(() => LoggingInterceptor());

}