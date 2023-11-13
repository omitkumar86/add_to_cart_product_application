import 'package:add_to_cart_product_application/provider/view_all_products_provider.dart';
import 'package:add_to_cart_product_application/utils/app_colors/app_colors.dart';
import 'package:add_to_cart_product_application/utils/app_style/app_style.dart';
import 'package:add_to_cart_product_application/view/screens/product/product_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../checkout/checkout_screen.dart';
import '../favorite/favorite_screen.dart';

class ProductScreen extends StatefulWidget {
  static const String routeName = 'product_screen';
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  bool isShopping = false;
  bool isFavorite = false;
  int selectedIndex = 0;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ViewAllProductsProvider>(context, listen: false).resetPage();
      Provider.of<ViewAllProductsProvider>(context, listen: false).clearList();
      final page = Provider.of<ViewAllProductsProvider>(context, listen: false).page;
      _load(reLoad: true, context: context, skip: page.toString(), limit: '');
      scrollController.addListener(_scrollListener);
      Provider.of<ViewAllProductsProvider>(context, listen: false).getAllProductsData(context: context);
    });
  }

  /// For Scroll Listener
  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      Provider.of<ViewAllProductsProvider>(context, listen: false).pageCounter(context: context);
      final page = Provider.of<ViewAllProductsProvider>(context, listen: false).page;
      _load(reLoad: true, context: context, skip: page.toString(), limit: 20);
      if (kDebugMode) {
        print("scrolling");
      }
    }
  }

  /// For Load Product Data
  _load({required bool reLoad, required BuildContext context, dynamic skip, dynamic limit}) async{
    await Provider.of<ViewAllProductsProvider>(context, listen: false).getAllProductsData(context: context, skip: skip, limit: limit,);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appPrimaryColor,
        title: Text('All Products', style: myStyleRoboto(fontSize: 16.sp, color: AppColors.appWhiteColor, fontWeight: FontWeight.w500),),
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed(CheckoutScreen.routeName);
                  },
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.appWhiteColor,
                        ),
                        child: Icon(Icons.shopping_cart_outlined, color: AppColors.appPrimaryColor, size: 18.sp,),
                      ),

                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 28.h,
                          width: 28.w,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.appRedColor,
                          ),
                          child: Text('0', style: myStyleRoboto(fontSize: 10.sp, color: AppColors.appWhiteColor, fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 8.w,),

                InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed(FavoriteScreen.routeName);
                  },
                  child: Icon(Icons.favorite_outline, color: AppColors.appWhiteColor, size: 25.sp,),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Consumer<ViewAllProductsProvider>(
        builder: (context, viewAllProductsProvider, child) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(top: 15.h,),
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
              child: Column(
                children: [

                  /// Product Cart
                  GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 20,
                        childAspectRatio: 4/4.5,
                      ),
                      itemCount: viewAllProductsProvider.productsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        if(index < viewAllProductsProvider.productsList.length){
                          final productsList = viewAllProductsProvider.productsList[index];
                          return InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetailsScreen(
                                id: productsList.id,
                                title: productsList.title,
                                description: productsList.description,
                                price: productsList.price,
                                discountPercentage: productsList.discountPercentage,
                                rating: productsList.rating,
                                stock: productsList.stock,
                                thumbnail: productsList.thumbnail,
                                images: productsList.images,
                              ),
                              ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: index % 2 == 0?12.w:0.w, right: index % 2 == 0?0.w:12.w),
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
                              child: Stack(
                                children: [

                                  /// Product
                                  Positioned(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Center(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10.r),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.contain,
                                                imageUrl: '${viewAllProductsProvider.productsList[index].thumbnail}',
                                                progressIndicatorBuilder: (context, url, downloadProgress) => Image.asset("assets/images/placeholder.jpg", fit: BoxFit.fill,),
                                                errorWidget: (context, url, error) => Image.asset("assets/images/placeholder.jpg", fit: BoxFit.fill,),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text('${viewAllProductsProvider.productsList[index].title}', style: myStyleRoboto(fontSize: 12.sp, color: AppColors.appBlackColor, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis,),
                                                Row(
                                                  children: [
                                                    Text('\$${(viewAllProductsProvider.productsList[index].price - viewAllProductsProvider.productsList[index].price * viewAllProductsProvider.productsList[index].discountPercentage / 100).toStringAsFixed(2)}', style: myStyleRoboto(fontSize: 12.sp, color: AppColors.appBlackColor.withOpacity(0.7), fontWeight: FontWeight.w500)),
                                                    SizedBox(width: 10.w,),
                                                    Text('\$${viewAllProductsProvider.productsList[index].price}', style: myStyleRoboto(fontSize: 12.sp, color: AppColors.appRedColor, fontWeight: FontWeight.w500, textDirection: TextDecoration.lineThrough, decorationColor: AppColors.appRedColor),),
                                                  ],
                                                ),


                                                Row(
                                                  children: [
                                                    Text('Stock', style: myStyleRoboto(fontSize: 12.sp, color: AppColors.appBlackColor.withOpacity(0.6), fontWeight: FontWeight.w400),),
                                                    LinearPercentIndicator(
                                                      width: 90.0,
                                                      animation: true,
                                                      lineHeight: 13.0,
                                                      animationDuration: 1500,
                                                      percent: viewAllProductsProvider.productsList[index].stock > 100?1:viewAllProductsProvider.productsList[index].stock/100,
                                                      center: Text("${viewAllProductsProvider.productsList[index].stock}", style: myStyleRoboto(fontSize: 10.sp, color: AppColors.appWhiteColor, fontWeight: FontWeight.w400),),
                                                      progressColor: Colors.orange,
                                                      barRadius: Radius.circular(10.r),
                                                      backgroundColor: AppColors.appBlackColor.withOpacity(0.3),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// Discount
                                  Positioned(
                                    top: 5,
                                    left: 0,
                                    child: InkWell(
                                      onTap: (){},
                                      child: Container(
                                        height: 20.h,
                                        width: 75.w,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(left: 5.w),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: AssetImage('assets/images/discount_card.png'), fit: BoxFit.fill),
                                        ),
                                        child: Text('${viewAllProductsProvider.productsList[index].discountPercentage.toStringAsFixed(2)}% OFF', style: myStyleRoboto(fontSize: 10.sp, color: AppColors.appWhiteColor, fontWeight: FontWeight.w500),),
                                      ),
                                    ),
                                  ),

                                  /// Favorite
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          isFavorite = !isFavorite;
                                        });
                                      },
                                      child: isFavorite == false?
                                      Icon(Icons.favorite_outline, color: AppColors.appPrimaryColor, size: 20.sp,):
                                      Icon(Icons.favorite, color: AppColors.appRedColor, size: 20.sp,),
                                    ),
                                  ),

                                  /// Increment and Decrement
                                  isShopping == true?
                                  Positioned(
                                    top: 90,
                                    right: 5,
                                    child: Container(
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
                                              setState(() {
                                                isShopping = !isShopping;
                                              });
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
                                          Text('12', style: myStyleRoboto(fontSize: 12.sp, color: AppColors.appWhiteColor, fontWeight: FontWeight.w500)),

                                          /// Increment
                                          InkWell(
                                            onTap: (){},
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
                                  ): SizedBox.shrink(),

                                  /// Shopping Cart
                                  isShopping == false?
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          isShopping = !isShopping;
                                        });
                                      },
                                      child: Container(
                                        height: 30.h,
                                        width: 30.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.appPrimaryColor,
                                        ),
                                        child: Icon(Icons.shopping_cart_outlined, color: AppColors.appWhiteColor, size: 14.sp,),
                                      ),
                                    ),
                                  ): SizedBox.shrink(),

                                  /// Stock Out Product
                                  viewAllProductsProvider.productsList[index].stock == 0?
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Center(
                                        child: Container(
                                          height: 240.h,
                                          width: 180.w,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.r),
                                            color: AppColors.appBlackColor.withOpacity(0.5),
                                          ),
                                          child: Text('Stock Out', style: myStyleRoboto(fontSize: 15.sp, color: AppColors.appWhiteColor, fontWeight: FontWeight.w500),),
                                        )
                                    ),
                                  ):SizedBox.shrink(),

                                ],
                              ),
                            ),
                          );
                        }else{
                          return Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Center(
                              child: Text("No Products Found", style: myStyleRoboto(fontSize: 16.sp, color: AppColors.appBlackColor, fontWeight: FontWeight.w500),),
                            ),
                          );
                        }
                      }
                  ),

                  /// Product Not Found
                  viewAllProductsProvider.isLoading == false && viewAllProductsProvider.productsList.isEmpty?
                  Center(child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Lottie.asset(height: 200.h, width: 200.w, "assets/lottie/no_product.json", fit: BoxFit.fitWidth),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 0.0),
                          child: Text('No Products Found'),
                        ),
                      ],
                    ),
                  ),):SizedBox.shrink(),

                  /// For Getting new Products
                  viewAllProductsProvider.isLoading == false?
                  const SizedBox() : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CircularProgressIndicator(color: AppColors.appPrimaryColor,),
                          const SizedBox(height: 5),
                          Text("Loading Products...", style: myStyleRoboto(fontSize: 13.sp, color: AppColors.appBlackColor.withOpacity(0.6)),),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h,),
                ],
              ),
            ),
          );
          },
),
    );
  }
}
