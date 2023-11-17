import 'package:add_to_cart_product_application/provider/cart_provider.dart';
import 'package:add_to_cart_product_application/provider/view_all_products_provider.dart';
import 'package:add_to_cart_product_application/utils/app_colors/app_colors.dart';
import 'package:add_to_cart_product_application/utils/constants/app_constants.dart';
import 'package:add_to_cart_product_application/utils/route_service/app_route_service.dart';
import 'package:add_to_cart_product_application/view/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => di.sl<ViewAllProductsProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.statusBarColor,
    ));

    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: SplashScreen.routeName,
          routes: AppRouteServices.routeServices,
        );
      }
    );
  }
}

