import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
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
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w,vertical:65.h ),
            child:Column(
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
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        height: 130.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              height: 50.h,
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
                  Text("\$ 0.0", style: myStyleRoboto(fontSize: 14.sp, color: AppColors.appBlackColor, fontWeight: FontWeight.w500),),
                ],
              ),
            ),

            /// Proceed Button
            InkWell(
              onTap: (){},
              child: Container(
                width: double.infinity,
                height: 50.h,
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
}
