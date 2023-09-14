import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../services/shared_pref.dart';
import '../../utils/constant/app_constants.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () {
      getScreen();
    });
    super.onInit();
  }

  getScreen() async {
    int loggedIn = await SharedPref.readInt(login);
    if (loggedIn == 1) {
      Get.offAllNamed(AppRoutes.homeScreen);
    } else {
      Get.offAllNamed(AppRoutes.loginScreen);
    }
  }
}
