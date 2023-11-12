import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_style/app_style.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = 'product_details_screen';
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
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
        title: Text('Details View', style: myStyleRoboto(fontSize: 16.sp, color: AppColors.appWhiteColor, fontWeight: FontWeight.w500),),
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
      ),
    );
  }
}
