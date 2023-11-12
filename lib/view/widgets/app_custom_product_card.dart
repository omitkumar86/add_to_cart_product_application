// import 'dart:convert';
// import 'dart:developer';
// import 'package:add_to_cart_product_application/provider/view_all_products_provider.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../provider/cart_provider.dart';
//
// class AppCustomProductCard extends StatelessWidget {
//   final dynamic model;
//   final String imageSrc;
//   final Function() onPressed;
//   final TextStyle? titleStyle;
//   final TextStyle? subTitleStyle;
//   final TextStyle? priceTitleStyle;
//   final double? titleFont;
//   final Color? fontColor;
//   final FontWeight? titleFontWeight;
//   final double? topHeight;
//   final double? botHeight;
//   final double? topWidth;
//   final double? botWidth;
//   final double? radius;
//   final double? borderWidth;
//
//   AppCustomProductCard({
//     required this.model,
//     required this.imageSrc,
//     required this.onPressed,
//     this.titleStyle,
//     this.subTitleStyle,
//     this.priceTitleStyle,
//     this.titleFont,
//     this.fontColor,
//     this.titleFontWeight,
//     this.topHeight,
//     this.botHeight,
//     this.topWidth,
//     this.botWidth,
//     this.radius,
//     this.borderWidth,Key? key}) : super(key: key);
//
//   final ValueNotifier<bool> addCart = ValueNotifier(false);
//
//   @override
//   Widget build(BuildContext context) {
//
//     int _index = 0;
//
//     dynamic unitTitle;
//     dynamic unit;
//     List<dynamic>? options = [];
//     ProductDetailsData productModel = model;
//     productModel.choiceOptions!.forEach((element) {
//       if(productModel.unit.toString().contains(element.title.toString())){
//         unitTitle = productModel.unit.toString();
//         unit = element.title.toString();
//         options = element.options;
//       }
//     });
//
//     return InkWell(
//       onTap: (){
//         onPressed();
//       },
//       child: Consumer2<CartProvider, ViewAllProductsProvider>(
//         builder: (context, cartProvider, viewAllProductsProvider, _){
//
//           if(cartProvider.cartList!.indexWhere((element) => element.id == model.id) == -1){
//             addCart.value=false;
//           }
//           else{
//             addCart.value=true;
//           }
//
//           return Stack(
//             children: [
//
//               Card(
//                 elevation: 1,
//                 child: Container(
//                   height: 245.h,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                         color: const Color(0xffCBCBCB),
//                         width: 0.5
//                     ),
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r),topRight: Radius.circular(4.r)),
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//
//                       Stack(
//                         children: [
//
//                           Container(
//                             // padding:const EdgeInsets.all(10),
//                             height: topHeight??162.h,
//                             width: topWidth??500.w,
//                             child: Center(
//                               child: CachedNetworkImage(
//                                 fit: BoxFit.contain,
//                                 imageUrl: imageSrc,
//                                 progressIndicatorBuilder: (context, url, downloadProgress) => Image.asset("assets/images/placeholder.jpg",height:topHeight??142.h,width: topWidth??162.w,fit: BoxFit.cover,),
//                                 errorWidget: (context, url, error) => Image.asset("assets/images/placeholder.jpg",height: 162.h,width: 162.w,fit: BoxFit.cover,),
//                               ),
//                             ),
//                           ),
//                           model.discount! != 0 && model.unitPrice.toString().length > 4?Positioned(
//                             top: 0,
//                             right: 0,
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 5.w),
//                               height: 20.h,
//                               // width: 80.w,
//                               decoration: BoxDecoration(
//                                   color: Theme.of(context).primaryColor,
//                                   borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(5.r),
//                                       bottomRight: Radius.circular(5.r),
//                                       topLeft: Radius.circular(5.r),
//                                       bottomLeft: Radius.circular(5.r)
//                                   )
//                               ),
//                               child: Center(child: Text('৳${model.unitPrice!}',style:priceTitleStyle??TextStyle(
//                                   decoration: TextDecoration.lineThrough,
//                                   color:model.discount == 0?Colors.transparent:Colors.white,
//                                   fontWeight:FontWeight.w500,fontSize:12.sp
//                               ))),
//                             ),
//                           ):SizedBox.shrink(),
//                         ],
//                       ),
//                       Container(
//                         // height: 82.h,
//                         // height: 86.h,
//                         width: 162.w,
//                         padding: EdgeInsets.symmetric(horizontal: 8.w),
//                         decoration: BoxDecoration(
//                           color: AppColorResources.WHITE,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(model.name.toString(),maxLines: 1,style:titleStyle??TextStyle(color:fontColor??AppColorResources.CARD_BLACK_TEXT_COLOR,fontWeight:titleFontWeight??FontWeight.w600,fontSize:titleFont??14.sp)),
//                             //  AppCustomSizeBox(height: 6.h,),
//                             //   Text(model.name.toString(),style:subTitleStyle??TextStyle(color:AppColorResources.CARD_GRAY_TEXT_COLOR,fontWeight:FontWeight.w600,fontSize:14.sp,letterSpacing: 0.7)),
//                             //  AppCustomSizeBox(height: 6.h,),
//
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.max,
//                               children: [
//                                 unitTitle != null?Text("${unitTitle}: ",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500),):Text(""),
//                                 // options!=null && options!.length> 0?Text("${options!.toList()}"):SizedBox(),
//                                 options != null && options!.length > 0?Container(
//                                   height: 20.h,
//                                   // width: 170,
//                                   // color: Colors.amber,
//                                   child: ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       physics: NeverScrollableScrollPhysics(),
//                                       shrinkWrap: true,
//                                       itemCount: options!.length,
//                                       itemBuilder: (context, index){
//                                         return Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             Text("${options![0]}",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500),),
//                                             Text("${unit}",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500),),
//                                           ],
//                                         );
//                                       }),
//                                 ):SizedBox.shrink()
//                               ],
//                             ),
//                             SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 children: [
//                                   Text('৳${model.discount!!=0?model.unitPrice!-model.discount!:model.unitPrice!} ',style:priceTitleStyle??TextStyle(color:AppColorResources.CARD_ORANGE_TEXT_COLOR,fontWeight:FontWeight.w700,fontSize:24.sp)),
//                                   AppCustomSizeBox(height: 5.w,),
//                                   // model.unitPrice!.toString().length <= 3?model.discount!!=0?Text('৳${model.unitPrice!}',style:priceTitleStyle??TextStyle(decoration: TextDecoration.lineThrough,color:model.discount==0?Colors.transparent:AppColorResources.CARD_BLACK_DISCOUNT_TEXT_COLOR,fontWeight:FontWeight.w700,fontSize:14.sp)):SizedBox.shrink():SizedBox.shrink(),
//                                   model.unitPrice!.toString().length <= 4?Text('৳${model.unitPrice!}',style:priceTitleStyle??TextStyle(decoration: TextDecoration.lineThrough,color:model.discount==0?Colors.transparent:AppColorResources.RED,fontWeight:FontWeight.w700,fontSize:14.sp)):SizedBox.shrink(),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               // Text("${title} : ${value}"),
//
//               /// Add to cart for shopping button
//               ValueListenableBuilder(valueListenable: addCart, builder: (context, value, _){
//                     return addCart.value == false
//                         ?Positioned(
//                           bottom: 5.h,
//                           right: 5.w,
//                           child: AppCustomOrgBackground(
//                             // color: Colors.amber,
//                             height: 40.h,
//                             width: 40.h,
//                             shape: BoxShape.circle,
//                             child: Center(
//                                 child: IconButton(icon: Icon(Icons.shopping_cart,size: 25.h,color: Colors.white,),
//                                     onPressed:() {
//                                       // addCart.value = !addCart.value;
//                                       if(Provider.of<AuthProvider>(context,listen: false).getAuthToken().length>0){
//                                         if(cartProvider.addToCartCartDataIsLoading == false){
//                                           addCart.value = false;
//                                           print(">>>>>>>>>>>>>>>>>>>>>>>>${model.id}");
//                                           Map<String,dynamic> map = getProductDefaultChoice(productModel, context);
//                                           // Map<String,dynamic> map = {
//                                           //   "product_id": productDetailsProvider.productDetailsData!.id.toString(),
//                                           //   "quantity": 1
//                                           // };
//                                           for (var e in map.entries.toList()) {
//                                             var key = e.key;
//                                             var lc = key.toLowerCase();
//                                             if (lc == "product_id") {
//                                               lc="id";
//                                               map.remove(key);
//                                               map[lc] = e.value;
//                                             }
//                                           }
//                                           log("======> add to cart query-parameter <======");
//                                           log("======> ${map}<======");
//                                           Provider.of<CartProvider>(context,listen: false).addToCartRemote(context, map, productModel);
//                                         }
//                                       }else{
//                                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendOTPPageWithNumberOrEmailSignIn(isProceedButton: false,isOrderPage: false,isAddToCartOrBuy: true,isCheckoutButton: false,isUnAuthorized: false,))).then((value) {
//                                           if(Provider.of<AuthProvider>(context,listen: false).getAuthToken().length>0){
//                                             if(cartProvider.addToCartCartDataIsLoading == false){
//                                               addCart.value = false;
//                                               print(">>>>>>>>>>>>>>>>>>>>>>>>${model.id}");
//                                               Map<String,dynamic> map = getProductDefaultChoice(productModel, context);
//                                               // Map<String,dynamic> map = {
//                                               //   "product_id": productDetailsProvider.productDetailsData!.id.toString(),
//                                               //   "quantity": 1
//                                               // };
//                                               for (var e in map.entries.toList()) {
//                                                 var key = e.key;
//                                                 var lc = key.toLowerCase();
//                                                 if (lc == "product_id") {
//                                                   lc="id";
//                                                   map.remove(key);
//                                                   map[lc] = e.value;
//                                                 }
//                                               }
//                                               log("======> add to cart quire queryparameter <======");
//                                               log("======> ${map}<======");
//                                               Provider.of<CartProvider>(context,listen: false).addToCartRemote(context, map, productModel);
//                                             }
//                                           }
//                                           return true;
//                                         });
//
//                                         // if(kDebugMode){
//                                         //   print(cartProvider.cartList!.contains(model.id));
//                                         // }
//                                         // if (addCart.value == true) {
//                                         //   print("I am in");
//                                         //   model.productQuantity = 1;
//                                         //
//                                         //   if(kDebugMode){
//                                         //     print(model.thumbnail.toString());
//                                         //   }
//                                         //
//                                         //   cartProvider.addCartList(model);
//                                         // }
//                                       }
//                                     }
//
//                                 )
//                             ),
//                           )
//                     ):SizedBox();
//                   }),
//
//               // addCart.value == false?Positioned(
//               //     bottom: 5.h,
//               //     right: 5.w,
//               //     child: AppCustomOrgBackground(
//               //       // color: Colors.amber,
//               //       height: 40.h,
//               //       width: 40.h,
//               //       shape: BoxShape.circle,
//               //       child: Center(
//               //           child: IconButton(icon: Icon(Icons.shopping_cart,size: 25.h,color: Colors.white,),
//               //               onPressed:() {
//               //                 // addCart.value = !addCart.value;
//               //                 if(Provider.of<AuthProvider>(context,listen: false).getAuthToken().length>0){
//               //                   addCart.value = false;
//               //                   print(">>>>>>>>>>>>>>>>>>>>>>>>${widget.model.id}");
//               //                   Map<String,dynamic> map=getProductDefaultChoice(productModel, context);
//               //                   for (var e in map.entries.toList()) {
//               //                     var key = e.key;
//               //                     var lc = key.toLowerCase();
//               //                     if (lc == "product_id") {
//               //                       lc="id";
//               //                       map.remove(key);
//               //                       map[lc] = e.value;
//               //                     }
//               //                   }
//               //                   log("======> add to cart query-parameter <======");
//               //                   log("======> ${map}<======");
//               //                   Provider.of<CartProvider>(context,listen: false).addToCartRemote(context, map, widget.model);
//               //                 }else{
//               //                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInPage(isProceedButton: false,isOrderPage: false,isAddToCartOrBuy: true,isCheckoutButton: false,isUnAuthorized: false,))).then((value) {
//               //                     if(Provider.of<AuthProvider>(context,listen: false).getAuthToken().length>0){
//               //                       addCart.value = false;
//               //                       print(">>>>>>>>>>>>>>>>>>>>>>>>${widget.model.id}");
//               //                       Map<String,dynamic> map=getProductDefaultChoice(productModel, context);
//               //                       for (var e in map.entries.toList()) {
//               //                         var key = e.key;
//               //                         var lc = key.toLowerCase();
//               //                         if (lc == "product_id") {
//               //                           lc="id";
//               //                           map.remove(key);
//               //                           map[lc] = e.value;
//               //                         }
//               //                       }
//               //                       log("======> add to cart quire queryparameter <======");
//               //                       log("======> ${map}<======");
//               //                       Provider.of<CartProvider>(context,listen: false).addToCartRemote(context, map, widget.model);
//               //                     }
//               //                     return true;
//               //                   });
//               //
//               //                   // if(kDebugMode){
//               //                   //   print(cartProvider.cartList!.contains(model.id));
//               //                   // }
//               //                   // if (addCart.value == true) {
//               //                   //   print("I am in");
//               //                   //   model.productQuantity = 1;
//               //                   //
//               //                   //   if(kDebugMode){
//               //                   //     print(model.thumbnail.toString());
//               //                   //   }
//               //                   //
//               //                   //   cartProvider.addCartList(model);
//               //                   // }
//               //                 }
//               //               }
//               //
//               //           )
//               //       ),
//               //     )
//               // ):SizedBox(),
//
//               /// Update cart for increment and decrement
//               ValueListenableBuilder(valueListenable: addCart, builder: (context, value, _){
//                 return addCart.value == true ?Positioned(bottom: 90.h,
//                     right: 20,
//                     left: 20,
//                     child: AppCustomOrgBackground(
//                       height: 40.h,
//                       radius: 54,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//
//                           /// Decrease
//                           IconButton(
//                             onPressed: cartProvider.updateCartDataIsLoading==false && cartProvider.getCartDataIsLoading==false ?(){
//                               buttonTypeGlobal.value="-";
//                               final cartModel=cartProvider.cartList!.firstWhere((element) => element.id==model.id);
//                               productIdGlobal.value = model.id.toString();
//                               print("Get cartModel==>${cartModel.id}");
//                               int cartIndex = cartProvider.cartList!.indexWhere((element) => element.id==productModel.id);
//                               if(cartProvider.cartList![cartIndex].productQuantity!>1){
//
//                                 print("/////// ${cartModel.id}");
//                                 if(Provider.of<AuthProvider>(context,listen: false).getAuthToken().length>0){
//                                   print("dekhi.......${cartProvider.cartList!.firstWhere((element) => element.id.toString()==model.id.toString()).cartId}");
//                                   Map<String,dynamic> map={
//                                     // "key": cartProvider.cartList!.firstWhere((element) => element.id.toString()==model.id.toString()).cartId,
//                                     // "quantity":"${cartProvider.cartList!.firstWhere((element) => element.id==model.id).productQuantity!-1}"
//                                     "key": cartProvider.cartList![cartIndex].cartId.toString(),
//                                     "quantity": "${cartProvider.cartList![cartIndex].productQuantity!-1}"
//                                   };
//                                   Provider.of<CartProvider>(context,listen: false).updateCart(context, map, cartIndex, cartProvider.cartList![cartIndex].productQuantity!-1);
//                                 }
//                                 cartProvider.removeQuantity(cartModel);
//                               }
//                               else{
//
//                                 // if(Provider.of<AuthProvider>(context,listen: false).getAuthToken().length>0){
//                                 //   Provider.of<AddToCartProvider>(context,listen: false).removeCart(context,"${cartmodel.id}");
//                                 // }
//                                 // print("/////// +++++${cartmodel.id}");
//                                 // pPageProvider.removeCartList(cartmodel);
//                                 // pPageProvider.cartValue=0;
//                                 // addCart.value=false;
//
//                               }
//
//
//                             } : null,
//                             icon: cartProvider.updateCartDataIsLoading==true && productIdGlobal.value.toString()==model.id.toString() && buttonTypeGlobal.value.toString()=="-"
//                                 ? Icon(Icons.remove,size: 25.h,color:Colors.white24)
//                                 : Icon(Icons.remove,color: Colors.white,)
//                             ,),
//
//                           Text(
//                             '${cartProvider.cartList!.firstWhere((element) => element.id == model.id).productQuantity}',
//                             style: TextStyle(fontSize: 24.sp,color:Colors.white,fontWeight: FontWeight.w600),),
//
//                           /// Increase
//                           IconButton(
//                               onPressed: cartProvider.updateCartDataIsLoading == false && cartProvider.getCartDataIsLoading==false  ?(){
//                                 productIdGlobal.value = model.id.toString();
//                                 buttonTypeGlobal.value = "+";
//                                 print("check product id====>${productIdGlobal.value}Product id ====>${model.id}");
//                                 print("check product id====>${productIdGlobal.value}Product id ====>${model.id}");
//                                 int cartIndex = cartProvider.cartList!.indexWhere((item) => item.id==model.id);
//                                 print("/////// $cartIndex");
//                                 if(cartProvider.cartList![cartIndex].currentStock!>cartProvider.cartList![cartIndex].productQuantity!){
//                                   if(Provider.of<AuthProvider>(context,listen: false).getAuthToken().length>0){
//                                     Map<String,dynamic> map={
//                                       // "key":cartProvider.cartList!.firstWhere((element) => element.id.toString()==model.id.toString()).cartId,
//                                       // //"quantity":"${pPageProvider.cartList!.firstWhere((element) => element.id==model.id).productQuantity!+1}"
//                                       // "quantity":"${cartProvider.cartList!.firstWhere((element) => element.id==model.id).productQuantity!+1}"
//                                       "key": cartProvider.cartList![cartIndex].cartId.toString(),
//                                       "quantity": "${cartProvider.cartList![cartIndex].productQuantity!+1}"
//                                     };
//                                     Provider.of<CartProvider>(context,listen: false).updateCart(context, map, cartIndex, cartProvider.cartList![cartIndex].productQuantity!+1);
//                                   }
//                                   // Navigator.push(context, MaterialPageRoute(builder: (_)=>OrderProcessingPage()));
//                                   else{
//                                     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                     //   elevation: 6.0,
//                                     //   duration: Duration(seconds: 1),
//                                     //   backgroundColor: Theme.of(context).primaryColor,
//                                     //   content: Text(
//                                     //     "Cart List is Empty",
//                                     //     style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
//                                     //   ),
//                                     // ));
//                                   }
//
//                                   // if(cartIndex == -1){
//                                   //   cartProvider.addToCart(model: widget.model);
//                                   // }else{
//                                   //   cartProvider.addQuantity(cartIndex);
//                                   // }
//                                 }
//                                 else{
//                                   ScaffoldMessenger.of(context).removeCurrentSnackBar();
//                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                     content: Text("Stock out"),
//                                     elevation: 6.0,
//                                     backgroundColor: Theme.of(context).primaryColor,
//                                     //     backgroundColor: Theme.of(context).primaryColor,
//                                   ));
//                                 }
//                               } : (){},
//                               // icon: pPageProvider.cartList!.firstWhere((element) => element.id==model.id).productQuantity!<model.currentStock!.toInt() ?
//                               icon: cartProvider.updateCartDataIsLoading == true &&productIdGlobal.value.toString() == model.id.toString() && buttonTypeGlobal.value.toString() == "+" ?
//                               Icon(Icons.add,size: 25.h,color:Colors.white24) : Icon(Icons.add,color: Colors.white,)),
//                         ],
//                       ),
//                     )):SizedBox();
//               }),
//
//               // addCart.value == true ?Positioned(bottom: 90.h,
//               //     right: 20,
//               //     left: 20,
//               //     child: AppCustomOrgBackground(
//               //         height: 40.h,
//               //         radius: 54,
//               //         child: Row(
//               //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //           children: [
//               //
//               //             /// Decrease
//               //             IconButton(
//               //               onPressed: cartProvider.updateCartDataIsLoading==false && cartProvider.getCartDataIsLoading==false ?(){
//               //                 buttonTypeGlobal.value="-";
//               //                 final cartModel=cartProvider.cartList!.firstWhere((element) => element.id==widget.model.id);
//               //                 productIdGlobal.value = widget.model.id.toString();
//               //                 print("Get cartModel==>${cartModel.id}");
//               //                 //int cartIndex = pPageProvider.cartList.indexWhere((item) => item.productId==products[index].productId);
//               //                 if(cartModel.productQuantity!>1){
//               //
//               //                   print("/////// ${cartModel.id}");
//               //                   if(Provider.of<AuthProvider>(context,listen: false).getAuthToken().length>0){
//               //                     print("dekhi.......${cartProvider.cartList!.firstWhere((element) => element.id.toString()==widget.model.id.toString()).cartId}");
//               //                     Map<String,dynamic> map={
//               //                       "key": cartProvider.cartList!.firstWhere((element) => element.id.toString()==widget.model.id.toString()).cartId,
//               //                       "quantity":"${cartProvider.cartList!.firstWhere((element) => element.id==widget.model.id).productQuantity!-1}"
//               //                     };
//               //                     Provider.of<CartProvider>(context,listen: false).updateCart(context, map, cartProvider.cartList!.indexWhere((element) => element.id==productModel.id), cartProvider.cartList!.firstWhere((element) => element.id==widget.model.id).productQuantity!-1);
//               //                   }
//               //                   cartProvider.removeQuantity(cartModel);
//               //                 }
//               //                 else{
//               //
//               //                   // if(Provider.of<AuthProvider>(context,listen: false).getAuthToken().length>0){
//               //                   //   Provider.of<AddToCartProvider>(context,listen: false).removeCart(context,"${cartmodel.id}");
//               //                   // }
//               //                   // print("/////// +++++${cartmodel.id}");
//               //                   // pPageProvider.removeCartList(cartmodel);
//               //                   // pPageProvider.cartValue=0;
//               //                   // addCart.value=false;
//               //
//               //                 }
//               //
//               //
//               //               } : null,
//               //               icon: cartProvider.updateCartDataIsLoading==true && productIdGlobal.value.toString()==widget.model.id.toString() && buttonTypeGlobal.value.toString()=="-"
//               //                   ? Icon(Icons.remove,size: 25.h,color:Colors.white24)
//               //                   : Icon(Icons.remove,color: Colors.white,)
//               //               ,),
//               //
//               //             Text(
//               //               '${cartProvider.cartList!.firstWhere((element) => element.id == widget.model.id).productQuantity}',
//               //               style: TextStyle(fontSize: 24.sp,color:Colors.white,fontWeight: FontWeight.w600),),
//               //
//               //             /// Increase
//               //             IconButton(
//               //                 onPressed: cartProvider.updateCartDataIsLoading == false && cartProvider.getCartDataIsLoading==false  ?(){
//               //                   productIdGlobal.value = widget.model.id.toString();
//               //                   buttonTypeGlobal.value = "+";
//               //                   print("check product id====>${productIdGlobal.value}Product id ====>${widget.model.id}");
//               //                   print("check product id====>${productIdGlobal.value}Product id ====>${widget.model.id}");
//               //                   int cartIndex = cartProvider.cartList!.indexWhere((item) => item.id==widget.model.id);
//               //                   print("/////// $cartIndex");
//               //                   if(cartProvider.cartList!.firstWhere((element) => element.id==widget.model.id).productQuantity!<widget.model.currentStock!.toInt()){
//               //                     if(Provider.of<AuthProvider>(context,listen: false).getAuthToken().length>0){
//               //                       Map<String,dynamic> map={
//               //                         "key":cartProvider.cartList!.firstWhere((element) => element.id.toString()==widget.model.id.toString()).cartId,
//               //                         //"quantity":"${pPageProvider.cartList!.firstWhere((element) => element.id==model.id).productQuantity!+1}"
//               //                         "quantity":"${cartProvider.cartList!.firstWhere((element) => element.id==widget.model.id).productQuantity!+1}"
//               //                       };
//               //                       Provider.of<CartProvider>(context,listen: false).updateCart(context, map, cartProvider.cartList!.indexWhere((element) => element.id==productModel.id), cartProvider.cartList!.firstWhere((element) => element.id==widget.model.id).productQuantity!+1);
//               //                     }
//               //                     // Navigator.push(context, MaterialPageRoute(builder: (_)=>OrderProcessingPage()));
//               //                     else{
//               //                       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               //                       //   elevation: 6.0,
//               //                       //   duration: Duration(seconds: 1),
//               //                       //   backgroundColor: Theme.of(context).primaryColor,
//               //                       //   content: Text(
//               //                       //     "Cart List is Empty",
//               //                       //     style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
//               //                       //   ),
//               //                       // ));
//               //                     }
//               //
//               //                     // if(cartIndex == -1){
//               //                     //   cartProvider.addToCart(model: widget.model);
//               //                     // }else{
//               //                     //   cartProvider.addQuantity(cartIndex);
//               //                     // }
//               //                   }
//               //                   else{
//               //                     ScaffoldMessenger.of(context).removeCurrentSnackBar();
//               //                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               //                       content: Text("Stock out"),
//               //                       elevation: 6.0,
//               //                       backgroundColor: Theme.of(context).primaryColor,
//               //                       //     backgroundColor: Theme.of(context).primaryColor,
//               //                     ));
//               //                   }
//               //
//               //                 } : (){},
//               //                 // icon: pPageProvider.cartList!.firstWhere((element) => element.id==model.id).productQuantity!<model.currentStock!.toInt() ?
//               //                 icon: cartProvider.updateCartDataIsLoading == true &&productIdGlobal.value.toString() == widget.model.id.toString() && buttonTypeGlobal.value.toString() == "+" ?
//               //                 Icon(Icons.add,size: 25.h,color:Colors.white24) : Icon(Icons.add,color: Colors.white,)),
//               //           ],
//               //         ),
//               //     )):SizedBox()
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//
// Map<String, dynamic> getProductDefaultChoice(ProductDetailsData productModel, BuildContext context){
//
//   final productDetailsProvider = Provider.of<CategoryWiseProductDetailsProvider>(context, listen: false);
//
//    /// for product choice option
//    List<int> selectedChoiceIndex=[0,0,0,0,0,0,0,0,0,0,0,0,0,0];
//    List<dynamic> selectedChoice=['','','','','','','','','','','','','','',''];
//    List<dynamic> selectedOption=['','','','','','','','','','','','','','',''];
//
//    int selectedColorIndex = -1;
//    dynamic selectedColor;
//    Map<String, dynamic>? map;
//
//    if(productModel.choiceOptions!.length != 0 && productModel != null) {
//
//
//      if(kDebugMode){
//        print("=====> Product choiceOptions Not Null <=====");
//      }
//      int index = 0;
//      ///initially selected choice option
//      productModel.choiceOptions!.forEach((element) {
//        selectedChoiceIndex[index] = 0;               ///
//        selectedChoice[index] = element.options![0];  /// first index value is default choice
//        selectedOption[index] = element.name;         ///
//        index++;
//      });
//
//      /// initially selected color
//      if(productModel.colors != null && productModel.colors!.length != 0){
//        if(kDebugMode){
//          print("Check color");
//        }
//        selectedColor = productModel.colors![0].code;/// first index value is default color
//        selectedColorIndex = 0;
//        if(kDebugMode){
//          log(selectedColor);
//        }
//      }
//
//      if(kDebugMode){
//        log("=======");
//        log("======>selectedChoiceIndex = ${selectedChoiceIndex}");
//        log("======>selectedOption = ${selectedOption}");
//        log("======>selectedChoiceIndex = ${selectedChoiceIndex}");
//        log("======>selectedOption = ${selectedOption}");
//        log("======>selectedChoice = ${selectedChoice}");
//        log("======>selected color = ${selectedColor.toString()}");
//        log("=======");
//      }
//
//      /// dynamic map for color
//      if(selectedColor == null){
//        map = {
//          "product_id": productModel.id.toString(),
//          // "color": selectedColor.toString(),
//          // "${provider.productDetailsData!.choiceOptions![index].name}": selectedType.toString(),
//          "quantity": 1
//        };
//
//        if(kDebugMode){
//          log("=====>RequestData<====${jsonEncode(map)}");
//          log("=====>RequestData<====${jsonEncode(map)}");
//        }
//        int count = 0;
//        while(count < productModel.choiceOptions!.length){
//          map.addEntries({selectedOption[count].toString():selectedChoice[count].toString()}.entries);
//          count++;
//        }
//        if(kDebugMode){
//          log("=====>RequestData<====${jsonEncode(map)}");
//          log("=====>RequestData<====${jsonEncode(map)}");
//        }
//      }
//
//      if(selectedColor != null){
//        map = {
//          "product_id": productModel.id.toString(),
//          "color": selectedColor.toString(),
//          // "${provider.productDetailsData!.choiceOptions![index].name}": selectedType.toString(),
//          "quantity": 1
//        };
//        if(kDebugMode){
//          log("=====>RequestData<====${jsonEncode(map)}");
//          log("=====>RequestData<====${jsonEncode(map)}");
//        }
//
//        int count = 0;
//        while(count < productModel.choiceOptions!.length){
//          map.addEntries({selectedOption[count].toString():selectedChoice[count].toString()}.entries);
//          count++;
//        }
//        if(kDebugMode){
//          log("=====>RequestData<====${jsonEncode(map)}");
//          log("=====>RequestData<====${jsonEncode(map)}");
//        }
//
//      }
//    }
//    else{
//      if(productModel.colors != null && productModel.colors!.length != 0){
//        if(kDebugMode){
//          print("Check color");
//        }
//        selectedColor = productModel.colors![0].code;/// first index value is default color
//        selectedColorIndex = 0;
//        if(kDebugMode){
//          log(selectedColor);
//        }
//      }
//
//      if(selectedColor == null){
//        map = {
//          "product_id": productModel.id.toString(),
//          "quantity": 1
//        };
//      }else{
//        map = {
//          "product_id": productModel.id.toString(),
//          "color": selectedColor.toString(),
//          "quantity": 1
//        };
//      }
//    }
//    return map!;
//  }
//
// class ViewImage extends StatelessWidget {
//   final String? imageUrl;
//   ViewImage({this.imageUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         child: Center(
//           child: Hero(
//             tag: 'imageHero',
//             child: CachedNetworkImage(
//               fit: BoxFit.contain,
//               imageUrl: imageUrl!,
//               progressIndicatorBuilder: (context, url, downloadProgress) =>
//                   Image.asset("assets/images/placeholder.jpg",fit: BoxFit.fill,),
//               errorWidget: (context, url, error) => Image.asset("assets/images/placeholder.jpg",fit: BoxFit.fill,),
//             ),
//           ),
//         ),
//         onTap: () {
//           Navigator.pop(context);
//         },
//       ),
//     );
//   }
// }