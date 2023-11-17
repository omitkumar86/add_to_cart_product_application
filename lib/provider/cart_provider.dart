import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/model/response_model/view_all_products_response_model.dart';

class CartProvider with ChangeNotifier {
  String? _status;
  String? _message;
  bool _getCartDataIsLoading = false;
  bool _addToCartCartDataIsLoading = false;
  bool _addToBulkCartDataIsLoading = false;
  bool _updateCartDataIsLoading = false;
  bool _removeCartDataIsLoading = false;
  SharedPreferences? sharedPreferences;
  int _productQuantity = 1;
  double _cartTotal = 0.0;
  int _cartValue = 0;
  dynamic key;
  ViewAllProductsResponseModel? _viewAllProductsResponseModel;
  List<ProductData> _cartList = [];
  int _counter = 0;
  bool isShopping = false;
  bool _isFavorite = false;
  int? selectedProductId;



  /// Getter
  String? get status => _status;
  String? get message => _message;
  bool get getCartDataIsLoading => _getCartDataIsLoading;
  bool get addToCartCartDataIsLoading => _addToCartCartDataIsLoading;
  bool get addToBulkCartDataIsLoading => _addToBulkCartDataIsLoading;
  bool get updateCartDataIsLoading => _updateCartDataIsLoading;
  bool get removeCartDataIsLoading => _removeCartDataIsLoading;
  ViewAllProductsResponseModel? get viewAllProductsResponseModel => _viewAllProductsResponseModel;
  List<ProductData> get cartList => _cartList;
  int get productQuantity => _productQuantity;
  double get cartTotal => _cartTotal;
  int get cartValue => _cartValue;
  int get counter => _counter;
  bool get isFavorite => _isFavorite;



  /// For Clear cartList
  void clearList() {
    _cartList = [];
    _cartTotal = 0;
    _cartValue = 0;
    notifyListeners();
  }

  /// For Copy cart from remote to local
  Future<bool> addToCartLocal(ProductData cartModel) async{
    try{
      cartList.add(cartModel);
      calculateCartDetails();
      notifyListeners();

      return true;
    }catch(e){
      return false;
    }
  }

  /// For Calculate Cart Details
  calculateCartDetails() {
    if (cartList.isNotEmpty) {
      _cartTotal = 0;
      _cartValue = 0;
      cartList.forEach((element) {
        _cartTotal += ((element.price - element.price * element.discountPercentage/100)*element.productQuantity);
        _cartValue += (int.parse(element.productQuantity.toString()));
        notifyListeners();

        if(kDebugMode){
          print("card added total ${cartValue}");
        }

      });
      notifyListeners();
      return _cartTotal;
    } else {
      _cartTotal = 0;
      notifyListeners();
    }
  }

  /// For Add Quantity
  void addQuantity(dynamic index) {
    print(index);
    if (index > -1) {
      if(kDebugMode){
        print("Product id>>>"+cartList[index].id);
        print(cartList[index].title);
        print(">>>>>>>>>>>>>>>>>>>>>>>>${cartList[index].productQuantity}");
      }
      cartList[index].productQuantity = cartList[index].productQuantity! + 1;

      if(kDebugMode){
        print(cartList[index].productQuantity);
      }
      calculateCartDetails();
      notifyListeners();
    }
  }

  /// For Remove Quantity
  void removeQuantity(ProductData model) {
    if (model.productQuantity! > 1) {
      model.productQuantity = model.productQuantity! - 1;
      calculateCartDetails();
      notifyListeners();
    }
  }

  /// For Save Cart List
  Future<bool> saveCartList({String? key, List<ProductData>? value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key!, json.encode(value!));
  }

  /// For Add to Cart
  Future<bool> addToCart({ProductData? model, BuildContext? context, required dynamic cartId, required dynamic quantity}) async{
    bool? result = false;
    if (kDebugMode) {
      if (model != null) {
        print(model.productQuantity);
        print("Check ProductQuantity ============> ${model.title}");
        print("Check ProductQuantity ============> ${model.price}");
        print("Check ProductQuantity ============> ${model.id}");

      }
    }

    if (model != null) {
      final cartModel = ProductData(
        isShopping: model.isShopping,
        id: model.id,
        title: model.title,
        price: model.price,
        discountPercentage: model.discountPercentage,
        description: model.description,
        thumbnail: model.thumbnail,
        productQuantity: quantity != null && quantity > 1 ? quantity : 1,
        stock: model.stock,
      );

      try{
        addToCartLocal(cartModel).then((value){
          result = value;
        });
      }catch(e){
        result = false;
      }

      if (kDebugMode) {
        print("save cart====>");
      }

      saveCartList(key: 'cart_list', value: cartList);

      notifyListeners();
    }
    return result!;
  }

  /// For Update Quantity
  updateCartProductQuantity(int? index, int? quantity) {
    if(kDebugMode){
      print(index);
    }

    if (index! > -1) {
      if(kDebugMode){
        print(cartList[index].id);
        print(cartList[index].title);
        print(">>>>>>>>>>>>>>>>>>>>>>>>${cartList[index].productQuantity}");
      }

      cartList[index].productQuantity = quantity!;

      calculateCartDetails();
      notifyListeners();
    }
  }

  /// For Remove Cart List Api
  Future<bool> deleteProductFromCartLocal({required BuildContext context, dynamic id}) async{
    try{
      cartList.removeWhere((element) {
        return element.id.toString() == id.toString();
      });

      calculateCartDetails();
      notifyListeners();
      return true;
    }catch(e){
      return false;
    }
  }

}
