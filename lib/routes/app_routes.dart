import 'package:get/get.dart';
import 'package:myprofile/pages/edit_profile/edit_profile_binding.dart';
import 'package:myprofile/pages/edit_profile/edit_profile_view.dart';
import 'package:myprofile/pages/home/home_binding.dart';
import 'package:myprofile/pages/home/home_view.dart';
import 'package:myprofile/pages/auth/login/login_binding.dart';
import 'package:myprofile/pages/auth/login/login_view.dart';
import 'package:myprofile/pages/splash/splash_binding.dart';
import 'package:myprofile/pages/splash/splash_view.dart';

class AppRoutes {
  static String splashScreen = '/splashScreen';
  static String loginScreen = '/loginScreen';
  static String homeScreen = '/homeScreen';
  static String editScreen = '/editScreen';

  static List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: homeScreen,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: editScreen,
      page: () => const EditProfilePage(),
      binding: EditProfileBinding(),
    ),
  ];
}
