import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  int _counterBuilderBuild = 1;
  String? _status;
  String? _message;
  bool _getCartDataIsLoading = false;
  bool _addToCartCartDataIsLoading = false;
  bool _addToBulkCartDataIsLoading = false;
  bool _updateCartDataIsLoading = false;
  bool _removeCartDataIsLoading = false;
  SharedPreferences? sharedPreferences;
  int productQuantity = 1;
  double cartTotal = 0.0;
  int cartValue = 0;
  dynamic key;

  /// Getter
  int getcounterBuilderBuild(){
    _counterBuilderBuild++;
    notifyListeners();
    return _counterBuilderBuild;
  }
  ///
  String? get status => _status;
  String? get message => _message;
  bool get getCartDataIsLoading => _getCartDataIsLoading;
  bool get addToCartCartDataIsLoading => _addToCartCartDataIsLoading;
  bool get addToBulkCartDataIsLoading => _addToBulkCartDataIsLoading;
  bool get updateCartDataIsLoading => _updateCartDataIsLoading;
  bool get removeCartDataIsLoading => _removeCartDataIsLoading;


  // /// For Clear cartList
  // void clearList() {
  //   // cartList = [];
  //   cartTotal = 0;
  //   cartValue = 0;
  //   notifyListeners();
  // }
  //
  // /// For Copy cart from remote to local
  // Future<bool> addToCartLocal(ProductDetailsData cartModel) async{
  //   try{
  //     cartList!.add(cartModel);
  //     calculateCartDetails();
  //     notifyListeners();
  //
  //     return true;
  //   }catch(e){
  //     return false;
  //   }
  // }
  //
  // /// For Add Quantity
  // void addQuantity(int index) {
  //   print(index);
  //   if (index > -1) {
  //     if(kDebugMode){
  //       print(cartList![index].id);
  //       print(cartList![index].name);
  //       print(">>>>>>>>>>>>>>>>>>>>>>>>${cartList![index].productQuantity}");
  //     }
  //     //cartList![index].productQuantity!+1;
  //     cartList![index].productQuantity = cartList![index].productQuantity! + 1;
  //
  //     if(kDebugMode){
  //       print(cartList![index].productQuantity);
  //     }
  //     calculateCartDetails();
  //     notifyListeners();
  //   }
  // }
  //
  // /// For Save Cart List
  // Future<bool> saveCartList({String? key, List<ProductDetailsData>? value}) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.setString(key!, json.encode(value!));
  // }
  //
  // /// For Read Cart List
  // Future<List<ProductDetailsData>> readCartList({String? key}) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<ProductDetailsData> list = [];
  //   if (prefs.getString(key!) != null) {
  //     // list = json.decode(prefs.getString(key)!).cast<CategoryWiseProductData>();
  //     if(kDebugMode){
  //       print("get cart====>");
  //       print(prefs.getString(key)!);
  //     }
  //     return list;
  //   }
  //   return list;
  // }
  //
  //
  // /// For Remove Cart List
  // void removeCartList(ProductDetailsData model) {
  //   cartList!.removeWhere((element) => element.id == model.id);
  //   calculateCartDetails();
  //   notifyListeners();
  // }
  //
  // /// For Remove Cart List Api
  // Future<bool> deleteProductFromCartLocal(dynamic id) async{
  //   try{
  //     cartList!.removeWhere((element) {
  //       return element.cartId.toString() == id.toString();
  //     });
  //
  //     calculateCartDetails();
  //     notifyListeners();
  //     return true;
  //   }catch(e){
  //     return false;
  //   }
  // }
  //
  // /// For Update Quantity
  // void updateCartProductQuantity(int? index, int? quantity) {
  //
  //   log('Check =========> $index');
  //   log('Check =========> $index');
  //   log('Check =========> $index');
  //   log('Check =========> $index');
  //   log('Check =========> $index');
  //   log('Check =========> $index');
  //   //
  //   // print('Check Quantity ========> $quantity');
  //   // print('Check Quantity ========> $quantity');
  //   // print('Check Quantity ========> $quantity');
  //   // print('Check Quantity ========> $quantity');
  //
  //
  //   if(kDebugMode){
  //     print(index);
  //   }
  //
  //   if (index! > -1) {
  //
  //     if(kDebugMode){
  //       print(cartList![index].id);
  //       print(cartList![index].name);
  //       print(">>>>>>>>>>>>>>>>>>>>>>>>${cartList![index].productQuantity}");
  //     }
  //
  //     //cartList![index].productQuantity!+1;
  //     cartList![index].productQuantity = quantity!;
  //
  //     if(kDebugMode){
  //       print(cartList![index].productQuantity);
  //     }
  //
  //     calculateCartDetails();
  //     notifyListeners();
  //   }
  // }
  //
  // /// For Remove Quantity
  // void removeQuantity(ProductDetailsData model) {
  //   if (model.productQuantity! > 1) {
  //     model.productQuantity = model.productQuantity! - 1;
  //     calculateCartDetails();
  //     notifyListeners();
  //   }
  // }
  //
  // /// For Calculate Cart Details
  // void calculateCartDetails() {
  //   if (cartList!.isNotEmpty) {
  //     cartTotal = 0;
  //     cartValue = 0;
  //     cartList!.forEach((element) {
  //       cartTotal += (int.parse(element.unitPrice.toString()) -
  //               int.parse(element.discount.toString())) *
  //           int.parse(element.productQuantity.toString());
  //       cartValue += (int.parse(element.productQuantity.toString()));
  //       notifyListeners();
  //
  //       if(kDebugMode){
  //         print("card added total ${cartValue}");
  //       }
  //
  //     });
  //     notifyListeners();
  //   } else {
  //     cartTotal = 0;
  //     notifyListeners();
  //   }
  // }
  //
  // /// For Clear Cart Data
  // void clearCartData() {
  //   _data!.clear();
  //   notifyListeners();
  // }


}
