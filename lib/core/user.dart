import 'package:curriculum/core/database_helper.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/resumes.dart';
import 'auth/biometrics.dart';
import 'common.dart';

class UserController extends GetxController {
  DatabaseHelper db;
  UserController({required this.db});

  RxString username = ''.obs;
  RxString password = ''.obs;
  RxBool showPassword = false.obs;
  RxBool isEnabled = false.obs;
  RxString displayUsername = 'Guest'.obs;


  register() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool register = await db.register(username.value, password.value);

    if ( register ) {
      Get.offAll(() => const ResumesWidget());

      // if (await isSupported()) {
      //   showDialog(context: context, builder: (ctx) => BiometricAlert(
      //     onConfirm: () => saveLoginCredentials(username, password),
      //     onCancel: () {},
      //   ),);
      // }

      showSuccessMessage('register_screen.success'.tr);
      _prefs.setBool('logged', true);
      _prefs.setString('username', username.value);
      displayUsername.value = username.value;
    } else {
      showErrorMessage('register_screen.failed'.tr);
    }
  }

  login() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool res = await db.login(username.value, password.value);

    if ( res ) {
      Get.offAll(() => const ResumesWidget());

      showSuccessMessage('login_screen.success'.tr);

      if ( await isSupported() ) {
        // showDialog(context: context, builder: (ctx) => BiometricAlert(
        //   onConfirm: () => saveLoginCredentials(username, password),
        //   onCancel: () {},
        // ),);
      }

      _prefs.setBool('logged', true);
      _prefs.setString('username', username.value);
      displayUsername.value = username.value;
    } else {
      showErrorMessage('login_screen.failed'.tr);
    }
  }

  bool disabled() {
    return username.isEmpty || password.isEmpty;
  }

  isLoggedIn({bool logout = false}) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      bool logged = _prefs.getBool('logged')??false;

      if ( (!logout) && (logged || await biometricLogin() && await authenticate()) ) {
        displayUsername.value = _prefs.getString('username')??'';
        Get.offAll(() => const ResumesWidget());
      }
    } catch (e) {
      print('test');
    }
  }
}
