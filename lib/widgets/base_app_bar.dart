import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/user.dart';
import '../screens/navigation.dart';
import '../screens/resume/settings.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  UserController controller = Get.find<UserController>();
  BaseAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Center(
        child: GestureDetector(
          onTap: () => Get.to(() => const SettingsScreen()),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                shape: BoxShape.circle
            ),
            child:  Center(
              child: Obx(() => Text(
                controller.displayUsername.value[0].toUpperCase(),
                style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold
                ),)),
            ),
          ),
        ),
      ),
      title: Text('resumes_screen.title'.tr),
      actions: [
        GestureDetector(
          onTap: () async{
            // context.read<ResumeProvider>().setResume(Resume(experiences: [], educations: [], languages: []));
            Get.to(() => const NavigationScreen());
          },
          child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(Icons.add_circle)
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
