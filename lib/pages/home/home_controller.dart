import 'package:get/get.dart';
import 'package:myprofile/models/user_model.dart';

import '../../utils/helper/methods.dart';

class HomeController extends GetxController {
  late UserModel userModel; // User model to store user data
  RxBool isDataLoading = false.obs; // Observable boolean for data loading state
  // Function to fetch and load user data for the dashboard

  getDashBoardData() async {
    isDataLoading(true); // Set data loading state to true
    UserModel? user =
        await readDataFromSharedPreference(); // Read user data from shared preferences
    if (user != null) {
      userModel = user; // If user data exists, assign it to the userModel
    } else {
      onPresslogout(); // If no user data is found, trigger logout action
    }
    isDataLoading(false); // Set data loading state to false when done
  }
  // Function to generate a greeting message based on the time of day

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Hello, Good Morning';
    }
    if (hour < 17) {
      return 'Hello, Good Afternoon';
    }
    return 'Hello, Good Evening';
  }

  @override
  void onInit() {
    getDashBoardData(); // Initialize the controller by fetching dashboard data
    super.onInit();
  }
}
