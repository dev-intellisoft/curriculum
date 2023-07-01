import 'package:curriculum/core/common.dart';
import 'package:curriculum/core/user.dart';
import 'package:curriculum/screens/register.dart';
import 'package:flutter/material.dart';
import '../core/auth/auth.dart';
import '../core/auth/biometrics.dart';
import '../widgets/biometric_alert.dart';
import 'resumes.dart';
import 'package:get/get.dart';


class LoginWidget extends StatelessWidget {

  late final bool logout;
  LoginWidget({Key? key, this.logout = false}) : super(key: key);


  UserController controller = Get.find<UserController>();

   _init() {
     controller.isLoggedIn(logout:logout);
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset : true,
        body: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: SafeArea(
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60, bottom: 60),
                  child: Text('login_screen.app_name'.tr, style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold
                  ),),
                ),

                TextFormField(
                  onTap: () async {
                    if ( await biometricLogin() ){
                      if (await authenticate() ) {
                        Get.offAll(() => const ResumesWidget());
                      }
                    }
                  },
                  onChanged: (value) => controller.username.value = value,
                  decoration: InputDecoration(
                    labelText: 'username'.tr
                  ),
                ),

                const SizedBox(height: 15,),
                Obx(() => TextFormField(
                  onChanged: (value) => controller.password.value = value,
                  decoration:  InputDecoration(
                    isDense: true,
                    suffix: GestureDetector(
                      onTap: () => controller.showPassword.value = !controller.showPassword.value,
                      child: controller.showPassword.isTrue? const Icon(Icons.visibility_off): const Icon(Icons.visibility),
                    ),
                    labelText: 'password'.tr
                  ),
                  obscureText: !controller.showPassword.isTrue,
                )),

                const SizedBox(height: 15,),

                Obx(() => GestureDetector(
                  onTap: controller.disabled()?() {}:() => controller.login(),
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    height: 45,
                    child:  Center(
                        child: Text('login'.tr, style: TextStyle(
                            color: controller.disabled()?Colors.grey:Colors.white,
                            fontWeight: FontWeight.bold
                        ),)),
                    decoration: BoxDecoration(
                        color: controller.disabled()?Colors.grey[300]:Colors.blueAccent,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                )),

                GestureDetector(
                  onTap: () => Get.to(() => RegisterWidget()),
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    height: 45,
                    child: Center(
                      child: Text('login_screen.register'.tr, style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),)),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
