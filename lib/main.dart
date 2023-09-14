import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myprofile/pages/splash/splash_binding.dart';
import 'package:myprofile/routes/app_routes.dart';
import 'package:myprofile/utils/helper/responsive_utils.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyProfileApp());
}

class MyProfileApp extends StatelessWidget {
  const MyProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: getDesignSize(context),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: GetMaterialApp(
          initialBinding: SplashBinding(),
          initialRoute: AppRoutes.splashScreen,
          getPages: AppRoutes.pages,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
