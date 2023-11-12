import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_style/app_style.dart';

class FavoriteScreen extends StatefulWidget {
  static const String routeName = 'favorite_screen';
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
        title: Text('Favorite Product', style: myStyleRoboto(fontSize: 16.sp, color: AppColors.appWhiteColor, fontWeight: FontWeight.w500),),
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
