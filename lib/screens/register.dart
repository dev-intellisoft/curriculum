import 'package:curriculum/core/classes/user.dart';
import 'package:curriculum/core/common.dart';
import 'package:curriculum/core/user.dart';
import 'package:curriculum/screens/resumes.dart';
import 'package:flutter/material.dart';
import '../core/auth/auth.dart';
import '../core/auth/biometrics.dart';
import '../widgets/biometric_alert.dart';
import 'package:get/get.dart';

class RegisterWidget extends StatelessWidget {

  UserController controller = Get.find<UserController>();

  RegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset : true,
        appBar: AppBar( title: Text('register_screen.register'.tr),),
          body: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: SafeArea(
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange[200],
                        border: Border.all(
                          color: Colors.orange,
                          width: 1.0,
                          style: BorderStyle.solid
                        )
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 40,
                              child: Icon(Icons.info_outline)
                          ),
                          SizedBox(
                            width: 280,
                            child: Column(
                              children: [
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text('register_screen.text1'.tr),
                                ),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text('register_screen.text2'.tr),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    onChanged: (value) => controller.username.value = value,
                    decoration: InputDecoration(
                      labelText: 'username'.tr
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Obx(() => TextFormField(
                    obscureText: !controller.showPassword.isTrue,
                    onChanged: (value)  => controller.password.value = value,
                    decoration: InputDecoration(
                        labelText: 'password'.tr,
                        suffixIcon: GestureDetector(
                            onTap: () => controller.showPassword.value = !controller.showPassword.value,
                            child: Icon(controller.showPassword.isTrue?Icons.visibility_off:Icons.visibility)
                        )
                    ),
                  )),
                  const SizedBox(height: 20,),

                  Obx(() => GestureDetector(
                    onTap: controller.disabled()?() {}:() => controller.register(),
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: double.infinity,
                      height: 45,
                      child: Center(
                          child: Text('register'.tr, style: TextStyle(
                              color: !controller.disabled() ?Colors.white:Colors.grey,
                              fontWeight: FontWeight.bold
                          ),)),
                      decoration: BoxDecoration(
                          color: !controller.disabled() ? Colors.blueAccent:Colors.grey[300],
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  )),
                ],
              ),
            ),
          )
      ),
    );
  }
}
