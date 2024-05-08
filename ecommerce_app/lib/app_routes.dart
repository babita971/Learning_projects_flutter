import 'package:ecommerce_app/modules/profile/binding/profile_binding.dart';
import 'package:ecommerce_app/modules/profile/views/profile_screen.dart';
import 'package:ecommerce_app/modules/signup/binding/signup_binding.dart';
import 'package:ecommerce_app/modules/signup/views/signup_screen_view.dart';
import 'package:get/get.dart';

import 'modules/dashboard/binding/dashboard_binding.dart';
import 'modules/splash/binding/splash_screen_binding.dart';
import 'package:ecommerce_app/modules/checkout/binding/checkout_binding.dart';
import 'package:ecommerce_app/modules/order_history/binding/order_history_binding.dart';
import 'package:ecommerce_app/modules/cart/binding/cart_screen_binding.dart';

import 'modules/dashboard/views/dashboard_view.dart';
import 'modules/login/binding/login_binding.dart';
import 'modules/login/views/login_screen_view.dart';
import 'modules/splash/views/splash_screen_view.dart';
import 'package:ecommerce_app/modules/checkout/views/checkout_screen.dart';
import 'package:ecommerce_app/modules/order_history/views/order_history_screen.dart';
import 'package:ecommerce_app/modules/cart/views/cart_screen_view.dart';
import 'package:ecommerce_app/modules/kicker_page/views/kicker_screen_view.dart';
import 'package:ecommerce_app/modules/notification/views/notification_screen.dart';
import 'package:ecommerce_app/modules/wishlist/views/wishlist_screen.dart';

import 'package:ecommerce_app/app_pages.dart';

class Routes {
  List<GetPage> pages = [
    GetPage(
      name: Paths.SPLASH_SCREEN,
      page: () => SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Paths.LOGIN,
      page: () => LoginScreen(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: Paths.SIGNUP,
      page: () => SignUpScreen(),
      binding: SignUpScreenBinding(),
    ),
    GetPage(
      name: Paths.DASHBOARD,
      page: () => DashBoard(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Paths.CART,
      page: () => CartScreen(),
      binding: CartBinding(),
    ),
    GetPage(
      name: Paths.CHECKOUT,
      page: () => CheckoutScreen(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: Paths.ORDER_HISTORY,
      page: () => OrderHistoryScreen(),
      binding: OrderHistoryBinding(),
    ),
    GetPage(
      name: Paths.PROFILE,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(name: Paths.WISHLIST, page: () => WishlistScreen()),
    GetPage(name: Paths.NOTIFICATIONS, page: () => NotificationScreen()),
    GetPage(name: Paths.PRODUCT_PAGE, page: () => KickerPage()),
  ];
}
