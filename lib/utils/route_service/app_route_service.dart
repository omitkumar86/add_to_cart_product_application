import 'package:add_to_cart_product_application/view/screens/product/product_screen.dart';
import '../../view/screens/checkout/checkout_screen.dart';
import '../../view/screens/favorite/favorite_screen.dart';
import '../../view/screens/product/product_details_screen.dart';
import '../../view/screens/splash/splash_screen.dart';

class AppRouteServices {
  static final routeServices = {
    SplashScreen.routeName: (context) => SplashScreen(),
    ProductScreen.routeName: (context) => ProductScreen(),
    CheckoutScreen.routeName: (context) => CheckoutScreen(),
    ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
    FavoriteScreen.routeName: (context) => FavoriteScreen(),
  };
}