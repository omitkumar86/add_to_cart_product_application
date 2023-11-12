import 'package:add_to_cart_product_application/utils/app_style/app_style.dart';
import 'package:add_to_cart_product_application/view/screens/product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_colors/app_colors.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacementNamed(context, ProductScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appPrimaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/cart.png', height: 200.h, width: 200.w,),
            SizedBox(height: 20.h,),
            Text("E-Shopping", style: myStyleRoboto(fontSize: 22.sp, color: AppColors.appWhiteColor, letterSpacing: 2),),
          ],
        ),
      ),
    );
  }
}
