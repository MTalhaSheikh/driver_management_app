import 'package:driver_management_app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../bindings/home_binding.dart';
import '../bindings/login_binding.dart';
import '../bindings/map_binding.dart';
import '../bindings/profile_binding.dart';
import '../bindings/trip_info_binding.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/map_view.dart';
import '../views/profile_view.dart';
import '../views/splash_view.dart';
import '../views/trip_info_view.dart';

class AppPages {
  static const String initial = AppRoutes.splash;

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.tripInfo,
      page: () => const TripInfoView(),
      binding: TripInfoBinding(),
    ),
    GetPage(
      name: AppRoutes.map,
      page: () => const MapView(),
      binding: MapBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
