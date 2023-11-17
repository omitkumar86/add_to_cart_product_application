import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response_model/view_all_products_response_model.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/view_all_products_provider.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_style/app_style.dart';
import '../../widgets/image_view_screen.dart';
import '../checkout/checkout_screen.dart';
import 'package:collection/collection.dart';

class ProductDetailsScreen extends StatefulWidget {
  dynamic id;
  dynamic title;
  dynamic description;
  dynamic price;
  dynamic discountPercentage;
  dynamic rating;
  dynamic stock;
  dynamic thumbnail;
  List<String>? images;
  bool? isFavorite;
  dynamic productQuantity;
  static const String routeName = 'product_details_screen';
  ProductDetailsScreen({super.key, this.id, this.title, this.discountPercentage, this.stock, this.price, this.thumbnail, this.images, this.description, this.rating, this.isFavorite, this.productQuantity});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<CartProvider, ViewAllProductsProvider>(
        builder: (context, cartProvider, viewAllProductsProvider, child) {
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
              title: Text('Details View', style: myStyleRoboto(fontSize: 16.sp, color: AppColors.appWhiteColor, fontWeight: FontWeight.w500),),
              elevation: 0,
            ),
            body: RefreshIndicator(
              color: AppColors.appWhiteColor,
              backgroundColor: AppColors.appPrimaryColor,
              onRefresh: () {
                return Future<void>.delayed(const Duration(seconds: 2));
              },
              child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// For View Product Image
                      Container(
                        width: double.infinity,
                        height: 200.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFCBCBCB).withOpacity(0.4), width: 1),
                        ),
                        child: FittedBox(
                          child: GestureDetector(
                            child: Hero(
                              tag: 'imageHero',
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: "${widget.thumbnail}",
                                progressIndicatorBuilder: (context, url, downloadProgress) => const SizedBox.shrink(),
                                errorWidget: (context, url, error) => Image.asset("assets/images/placeholder.jpg",height: 260.h, width: 260.w,fit: BoxFit.fill,),
                              ),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_) {
                                return ViewImageScreen(imageUrl: "${widget.thumbnail}",);
                              }));
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h,),

                      /// choose multiple image
                      SizedBox(
                        height: 60.h,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.images!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 5),
                                      child: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            widget.thumbnail = widget.images![index];
                                          });
                                        },
                                        child: Container(
                                          height: 60.h,
                                          width: 60.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.6),
                                                spreadRadius: 0,
                                                blurRadius: 2,
                                                offset: Offset(1, 1), // changes position of shadow
                                              ),
                                            ],
                                            border: Border.all(width: 1, color: Color(0xffE37D4E)),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10.sp),
                                            child: Padding(
                                              padding: EdgeInsets.all(2.sp),
                                              child: CachedNetworkImage(
                                                imageUrl: "${widget.images![index]}",
                                                fit: BoxFit.fill,
                                                progressIndicatorBuilder: (context, url, downloadProgress) => const SizedBox.shrink(),
                                                errorWidget: (context, url, error) => Image.asset("assets/images/placeholder.jpg",height:60.h, width: 60.h, fit: BoxFit.fill,),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h,),

                      /// Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${widget.title}', style: myStyleRoboto(fontSize: 15.sp, color: AppColors.appBlackColor, fontWeight: FontWeight.w500), textAlign: TextAlign.left,),
                          InkWell(
                            onTap: (){
                              setState(() {
                                Provider.of<ViewAllProductsProvider>(context, listen: false).setIsFavorite(widget.isFavorite);
                                widget.isFavorite = !widget.isFavorite!;
                              });
                              Provider.of<ViewAllProductsProvider>(context, listen: false).saveFavoriteStatus(widget.id, widget.isFavorite!);
                            },
                            child: widget.isFavorite == false?
                            Icon(Icons.favorite_outline, color: AppColors.appPrimaryColor, size: 22.sp,):
                            Icon(Icons.favorite, color: AppColors.appRedColor, size: 22.sp,),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h,),

                      /// Price
                      Row(
                        children: [
                          Text('\$${(widget.price - widget.price * widget.discountPercentage / 100).toStringAsFixed(2)}', style: myStyleRoboto(fontSize: 13.sp, color: AppColors.appBlackColor, fontWeight: FontWeight.w500)),
                          SizedBox(width: 10.w,),
                          Text('\$${widget.price}', style: myStyleRoboto(fontSize: 13.sp, color: AppColors.appRedColor, fontWeight: FontWeight.w500, textDirection: TextDecoration.lineThrough, decorationColor: AppColors.appRedColor),),
                        ],
                      ),

                      SizedBox(height: 5.h,),

                      /// Stock
                      Row(
                        children: [
                          Text('Stock', style: myStyleRoboto(fontSize: 13.sp, color: AppColors.appBlackColor, fontWeight: FontWeight.w400),),
                          LinearPercentIndicator(
                            width: 150.0,
                            animation: true,
                            lineHeight: 13.0,
                            animationDuration: 1500,
                            percent: widget.stock > 100?1:widget.stock/100,
                            center: Text("${widget.stock}", style: myStyleRoboto(fontSize: 10.sp, color: AppColors.appWhiteColor, fontWeight: FontWeight.w400),),
                            progressColor: Colors.orange,
                            barRadius: Radius.circular(10.r),
                            backgroundColor: AppColors.appBlackColor.withOpacity(0.2),
                          ),
                        ],
                      ),

                      SizedBox(height: 15.h,),

                      /// Price Variant & Increment, Decrement Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              viewAllProductsProvider.productsList.firstWhere((product) => product.id == widget.id).isShopping == false && cartProvider.cartList.firstWhereOrNull((element) => element.id == widget.id)?.productQuantity == null?
                              InkWell(
                                onTap: (){
                                  setState(() {

                                    /// Model
                                    ProductData selectedProduct = viewAllProductsProvider.productsList.firstWhere((product) => product.id == widget.id);

                                    /// Find the product with the specific ID
                                    cartProvider.selectedProductId = viewAllProductsProvider.productsList.firstWhere((product) => product.id == widget.id).id;

                                    /// Set isShopping to true only for the selected item
                                    cartProvider.isShopping = viewAllProductsProvider.productsList.firstWhere((product) => product.id == widget.id).isShopping = true;

                                    cartProvider.addToCart(model: selectedProduct, context: context, cartId: 'cart_list', quantity: 1);

                                  });
                                },
                                child: Container(
                                  height: 30.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.appPrimaryColor,
                                  ),
                                  child: Icon(Icons.add, color: AppColors.appWhiteColor, size: 14.sp,),
                                ),
                              ):SizedBox.shrink(),

                              /// Increment & Decrement Button
                              viewAllProductsProvider.productsList.firstWhere((product) => product.id == widget.id).isShopping == true && cartProvider.cartList.firstWhereOrNull((element) => element.id == widget.id)?.productQuantity != null?
                              Container(
                                height: 30.h,
                                width: 110.w,
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
                                        int cartIndex = cartProvider.cartList.indexWhere((product) => product.id == widget.id);

                                        cartProvider.updateCartProductQuantity(cartIndex, cartProvider.cartList[cartIndex].productQuantity!-1);
                                        if(cartProvider.cartList[cartIndex].productQuantity ==0){
                                          viewAllProductsProvider.productsList.firstWhere((product) => product.id == widget.id).isShopping=false;
                                          if(cartProvider.cartList.isNotEmpty){
                                            cartProvider.deleteProductFromCartLocal(context: context, id: cartProvider.cartList[cartIndex].id.toString());
                                          }
                                          print("Check IsShopping>>>${viewAllProductsProvider.productsList.firstWhere((product) => product.id == widget.id).isShopping}");
                                          viewAllProductsProvider.productsList.firstWhere((product) => product.id == widget.id).isShopping == false;
                                        }

                                        print("Check ID :${cartProvider.cartList.firstWhereOrNull((element) => element.id == widget.id)?.productQuantity}");
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
                                    Text(cartProvider.cartList.firstWhereOrNull((product) => product.id == widget.id)?.productQuantity != null?'${cartProvider.cartList.firstWhereOrNull((product) => product.id == widget.id)?.productQuantity}':'0', style: myStyleRoboto(fontSize: 12.sp, color: AppColors.appWhiteColor, fontWeight: FontWeight.w500)),

                                    /// Increment
                                    InkWell(
                                      onTap: (){
                                        int cartIndex = cartProvider.cartList.indexWhere((product) => product.id == widget.id);
                                        cartProvider.updateCartProductQuantity(cartIndex, cartProvider.cartList[cartIndex].productQuantity!+1);
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
                              ):SizedBox.shrink(),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price Variant', style: myStyleRoboto(fontSize: 13.sp, color: AppColors.appBlackColor, fontWeight: FontWeight.w500)),
                              SizedBox(width: 10.w,),
                              Text(cartProvider.cartList.firstWhereOrNull((product) => product.id == widget.id)?.productQuantity != null?'\$${((widget.price - widget.price*widget.discountPercentage/100)*cartProvider.cartList.firstWhereOrNull((product) => product.id == widget.id)?.productQuantity).toStringAsFixed(2)}':'0.0', style: myStyleRoboto(fontSize: 13.sp, color: AppColors.appBlackColor.withOpacity(0.8), fontWeight: FontWeight.w500),),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 15.h,),

                      /// Product Details
                      Text('Product Details', style: myStyleRoboto(fontSize: 15.sp, color: AppColors.appBlackColor, fontWeight: FontWeight.w500), textAlign: TextAlign.left,),
                      Text('${widget.description}', style: myStyleRoboto(fontSize: 12.sp, color: AppColors.appBlackColor.withOpacity(0.5), fontWeight: FontWeight.w400), textAlign: TextAlign.justify,),

                      SizedBox(height: 15.h,),

                      /// Customer Rating
                      Text('Customer Ratings', style: myStyleRoboto(fontSize: 15.sp, color: AppColors.appBlackColor, fontWeight: FontWeight.w500), textAlign: TextAlign.left,),

                      SizedBox(height: 10.h,),

                      /// For Average Ratings
                      Row(
                        children: [
                          Text("(${widget.rating} of 5)", style: myStyleRoboto(fontSize: 13.sp, color: AppColors.appDeepOrangeColor, fontWeight: FontWeight.w500),),

                          SizedBox(width: 8.w,),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Average Ratings',
                                style: myStyleRoboto(fontSize: 12.sp, color: AppColors.appBlackColor.withOpacity(0.8), fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 5.h,),
                              RatingBarIndicator(
                                rating: double.tryParse(widget.rating.toString())??0.0,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 18.0,
                                direction: Axis.horizontal,
                              ),
                            ],
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              height: 60.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Buy Button
                  InkWell(
                    onTap: (){
                      ProductData selectedProduct = viewAllProductsProvider.productsList.firstWhere((product) => product.id == widget.id);

                      int cartIndex = cartProvider.cartList.indexWhere((item) {
                        return item.id.toString() == widget.id.toString();
                      });

                      if(cartIndex == -1){
                        cartProvider.isShopping = viewAllProductsProvider.productsList.firstWhere((product) => product.id == widget.id).isShopping = true;
                        cartProvider.addToCart(model: selectedProduct, context: context, cartId: 'cart_list', quantity: cartProvider.productQuantity == null? 1 : cartProvider.productQuantity ).then((value){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckoutScreen()));
                        });
                      }else{
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckoutScreen()));
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
                      child: Text("Buy Now", style: myStyleRoboto(fontSize: 16.sp, color: AppColors.appWhiteColor, fontWeight: FontWeight.w600),),
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
