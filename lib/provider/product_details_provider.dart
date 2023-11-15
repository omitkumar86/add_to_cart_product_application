import 'package:add_to_cart_product_application/data/model/response_model/view_all_products_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductDetailsProvider extends ChangeNotifier{

  bool _isLoading = false;
  ProductData? _productDetailsData;



  int? _counter;
  bool _isAddToCart = false;

  /// This map will use as queryParameter for price_variant, add_to_cart
  Map<String, dynamic>? _map;



  /// Setter Method
  void setMap(dynamic map){
    _map = map;
  }

  void setCounter(dynamic counter){
    _counter = counter;
  }

  void setProductDetailsData(dynamic productDetailsData){
    _productDetailsData = productDetailsData;
  }

  /// Getter
  bool get isLoading => _isLoading;
  ProductData? get productDetailsData => _productDetailsData;
  int? get counter => _counter;
  Map<String,dynamic>? get map => _map;
  bool get isAddToCart => _isAddToCart;


  /// For Clear Price Variant
  // void clearPriceVariant(){
  //   _priceVariantResponseModel = null;
  //   notifyListeners();
  // }


}