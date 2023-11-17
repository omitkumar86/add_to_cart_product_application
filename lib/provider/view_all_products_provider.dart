import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/datasource/remote/dio/dio_client.dart';
import '../data/model/base_model/api_response.dart';
import '../data/model/response_model/view_all_products_response_model.dart';
import '../data/repositories/view_all_products_repo.dart';

class ViewAllProductsProvider with ChangeNotifier{
  final DioClient dioClient;
  final ViewAllProductsRepo viewAllProductsRepo;

  ViewAllProductsProvider({required this.dioClient, required this.viewAllProductsRepo});


  bool _isLoading = false;
  ViewAllProductsResponseModel? _viewAllProductsResponseModel;
  ProductData? _productData;
  List<ProductData> _productsList = [];
  List<ProductData>? _newProductsList;
  int _page = 1;


  /// Getter
  bool get isLoading => _isLoading;
  ViewAllProductsResponseModel? get viewAllProductsResponseModel => _viewAllProductsResponseModel;
  ProductData? get productData => _productData;
  List<ProductData> get productsList => _productsList;
  List<ProductData>? get newProductsList => _newProductsList;
  int get page => _page;


  /// For All Products pagination

  /// For Reset Page
  void resetPage() {
    _page = 1;
    notifyListeners();
  }

  /// For Page Counter
  void pageCounter({required BuildContext context}) {
    ++_page;
    notifyListeners();
  }

  /// For Clear List
  void clearList(){
    _productsList.clear();
    notifyListeners();
  }


  /// For get all products data
  Future<List<ProductData>?> getAllProductsData({required BuildContext context, dynamic skip, dynamic limit}) async {

    _isLoading = true;
    notifyListeners();

    ApiResponse apiResponse = await viewAllProductsRepo.getAllProductsData(skip: skip, limit: limit);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

      _isLoading = false;
      _viewAllProductsResponseModel = null;
      _newProductsList = null;

      _viewAllProductsResponseModel = ViewAllProductsResponseModel.fromJson(apiResponse.response!.data);
      _newProductsList = _viewAllProductsResponseModel!.data!.productsList;
      _productsList = _productsList + _newProductsList!;

      notifyListeners();
    } else {
      _isLoading = false;
      notifyListeners();
    }
    return _productsList;
  }



  bool isSwitchSelectedStatus = false;

  changeSwitchValue(dynamic value){
    isSwitchSelectedStatus = !isSwitchSelectedStatus;
    notifyListeners();
  }


  bool? _isFavorite = false;


  bool? get isFavorite => _isFavorite;

  void setIsFavorite(dynamic isFavorite){
    isFavorite = _isFavorite;
  }

  // Function to save favorite status to shared preferences
  Future<void> saveFavoriteStatus(int productId, bool isFavorite) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Use the product ID as the key to store the favorite status
    await prefs.setBool('favorite_$productId', isFavorite);
    notifyListeners();
  }

  // Function to get favorite status from shared preferences
  Future<bool> getFavoriteStatus(int productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Use the product ID as the key to retrieve the favorite status
    return prefs.getBool('favorite_$productId') ?? false;
  }

}