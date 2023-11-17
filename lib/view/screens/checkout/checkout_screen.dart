import 'package:add_to_cart_product_application/provider/cart_provider.dart';
import 'package:add_to_cart_product_application/provider/view_all_products_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_style/app_style.dart';

class CheckoutScreen extends StatefulWidget {
  static const String routeName = 'checkout_screen';
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<CartProvider, ViewAllProductsProvider>(
        builder: (context, cartProvider, productsProvider, child) {
          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_outlined, color: AppColors.appWhiteColor,),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.appPrimaryColor,
              title: Text('Checkout', style: myStyleRoboto(fontSize: 16.sp, color: AppColors.appWhiteColor, fontWeight: FontWeight.w500),),
              elevation: 0,
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.appPrimaryColor.withOpacity(0.5),
                      AppColors.appWhiteColor,
                    ]
                ),
              ),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [

                    SizedBox(height: 10.h,),
                    cartProvider.cartList.isNotEmpty?
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cartProvider.cartList.length,
                      itemBuilder: (context, index){
                        final cartList = cartProvider.cartList[index];
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                          height: 85.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.5, 0.5),
                                color: AppColors.secondaryTextColor.withOpacity(0.6),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.contain,
                                    imageUrl: '${cartList.thumbnail}',
                                    progressIndicatorBuilder: (context, url, downloadProgress) => Image.asset("assets/images/placeholder.jpg", fit: BoxFit.fill,),
                                    errorWidget: (context, url, error) => Image.asset("assets/images/placeholder.jpg", fit: BoxFit.fill,),
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 8,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child: Text('${cartList.title}', style: myStyleRoboto(fontSize: 14.sp, color: AppColors.appBlackColor, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis,)),

                                          SizedBox(width: 5.w,),

                                          /// Delete Button
                                          InkWell(
                                            onTap: (){
                                              productsProvider.productsList.firstWhere((product) => product.id == cartList.id).isShopping = false;
                                              cartProvider.deleteProductFromCartLocal(context: context, id: cartList.id.toString()).then((value){
                                                productsProvider.productsList.firstWhere((product) => product.id == cartList.id).isShopping = false;
                                              });

                                            },
                                            child: Icon(Icons.delete_outline, color: AppColors.appRedColor, size: 20.sp,),
                                          ),
                                        ],
                                      ),

                                      /// Price
                                      Row(
                                        children: [
                                          Text('\$${(cartList.price - cartList.price * cartList.discountPercentage/100).toStringAsFixed(2)}', style: myStyleRoboto(fontSize: 12.sp, color: AppColors.appBlackColor, fontWeight: FontWeight.w500)),
                                          SizedBox(width: 10.w,),
                                          Text('\$${cartList.price}', style: myStyleRoboto(fontSize: 12.sp, color: AppColors.appRedColor, fontWeight: FontWeight.w500, textDirection: TextDecoration.lineThrough, decorationColor: AppColors.appRedColor),),
                                        ],
                                      ),

                                      /// Price Variant & Increment, Decrement Button
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('\$${((cartList.price - cartList.price * cartList.discountPercentage/100)*cartList.productQuantity).toStringAsFixed(2)}', style: myStyleRoboto(fontSize: 13.sp, color: AppColors.appBlackColor.withOpacity(0.8), fontWeight: FontWeight.w500),),

                                          /// Increment & Decrement Button
                                          Container(
                                            height: 30.h,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30.r),
                                              color: AppColors.appPrimaryColor,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                /// Decrement
                                                InkWell(
                                                  onTap: (){
                                                    cartProvider.updateCartProductQuantity(index, cartProvider.cartList[index].productQuantity!-1);
                                                    if(cartProvider.cartList[index].productQuantity == 0){
                                                      productsProvider.productsList.firstWhere((product) => product.id == cartList.id).isShopping = false;
                                                      if(cartProvider.cartList.isNotEmpty){
                                                        cartProvider.deleteProductFromCartLocal(context: context, id: cartProvider.cartList[index].id.toString());
                                                      }
                                                      print("Check IsShopping >>>${productsProvider.productsList.firstWhere((product) => product.id == productsProvider.productsList[index].id).isShopping}");
                                                      productsProvider.productsList.firstWhere((product) => product.id == cartList.id).isShopping = false;
                                                    }

                                                  },
                                                  child: Container(
                                                    height: 30.h,
                                                    width: 30.w,
                                                    margin: EdgeInsets.symmetric(vertical: 2.h),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColors.appWhiteColor,
                                                    ),
                                                    child: Icon(Icons.remove, color: AppColors.appBlackColor, size: 14.sp,),
                                                  ),
                                                ),

                                                /// Counter
                                                Text(cartProvider.cartList[index].productQuantity.toString(),
                                                  style: myStyleRoboto(fontSize: 12.sp, color: AppColors.appWhiteColor, fontWeight: FontWeight.w500,),
                                                ),


                                                /// Increment
                                                InkWell(
                                                  onTap: (){
                                                    cartProvider.updateCartProductQuantity(index, cartProvider.cartList[index].productQuantity! + 1);
                                                  },
                                                  child: Container(
                                                    height: 30.h,
                                                    width: 30.w,
                                                    margin: EdgeInsets.symmetric(vertical: 2.h),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColors.appWhiteColor,
                                                    ),
                                                    child: Icon(Icons.add, color: AppColors.appBlackColor, size: 14.sp,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ):
                    /// No Products Found in Cart
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Lottie.asset(height: 200.h, width: 200.w, "assets/lottie/no_product.json", fit: BoxFit.fitWidth),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20.0.h),
                              child: Text("No Products Found in Cart", style: myStyleRoboto(fontSize: 16.sp, color: AppColors.appWhiteColor, fontWeight: FontWeight.w500),),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 15.h,),

                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              height: 120.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: double.infinity,
                    height: 45.h,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(width: 1, color: AppColors.appPrimaryColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total", style: myStyleRoboto(fontSize: 14.sp, color: AppColors.appBlackColor, fontWeight: FontWeight.w500),),
                        Text("\$ ${cartProvider.cartTotal.toStringAsFixed(2)}", style: myStyleRoboto(fontSize: 14.sp, color: AppColors.appBlackColor, fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),

                  /// Proceed Button
                  InkWell(
                    onTap: (){
                      if(cartProvider.cartList.length > 0){
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          elevation: 6.0,
                          duration: Duration(seconds: 1),
                          backgroundColor: AppColors.appPrimaryColor,
                          content: Text(
                            "Please Login to account!",
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ));
                      }
                      else{
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          elevation: 6.0,
                          duration: Duration(seconds: 1),
                          backgroundColor: AppColors.appPrimaryColor,
                          content: Text(
                            "Cart List is Empty",
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ));
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 45.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.appPrimaryColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text("Proceed", style: myStyleRoboto(fontSize: 16.sp, color: AppColors.appWhiteColor, fontWeight: FontWeight.w600),),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
