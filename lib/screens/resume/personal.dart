import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/core/common.dart';
import 'package:curriculum/core/providers/resume_provider.dart';
import 'package:curriculum/core/resume.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_languages.dart';
import 'package:get/get.dart';

class PersonalWidget extends StatefulWidget {
  const PersonalWidget({ Key? key, }) : super(key: key);

  @override
  _PersonalWidget createState() => _PersonalWidget();
}

class _PersonalWidget extends State<PersonalWidget> {
  ResumeController controller = Get.find<ResumeController>();

  Color _renderLanguageLevelButtonColor (String level) {
    switch (level) {
      case 'native':
        return Colors.green;
      case 'fluent':
        return Colors.greenAccent;
      case 'advanced':
        return Colors.orange;
      case 'intermediate':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  KeyEventResult _handleKeyPress(FocusNode node, RawKeyEvent event) {
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    Resume resume = context.read<ResumeProvider>().getResume();
    TextEditingController _name = TextEditingController(text: controller.name.value);
    TextEditingController _firstName = TextEditingController(text: controller.firstName.value);
    TextEditingController _lastName = TextEditingController(text: controller.lastName.value);
    TextEditingController _telephone = TextEditingController(text: controller.telephone.value);
    TextEditingController _email = TextEditingController(text: controller.email.value);
    TextEditingController _location = TextEditingController(text: controller.location.value);
    TextEditingController _linkedIn = TextEditingController(text: controller.linkedIn.value);
    TextEditingController _github = TextEditingController(text: controller.github.value);
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset : true,

      appBar: AppBar(
        title: Text('personal_info_screen.title'.tr),
        actions: [
          Obx(() {
            return GestureDetector(
              onTap: () {
                if ( controller.name.value == '' ) {
                  return;
                }
                // context.read<ResumeProvider>().saveResume(resume);
                showSuccessMessage('personal_info_screen.success'.tr);
              },
              child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.save_rounded,
                    color: controller.name.value == ''?Colors.grey:Colors.blueAccent,)
              ),
            );
          })
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(right: 15, left: 15),
        child: ListView(
          children: [
            const SizedBox(height: 15,),
            Focus(
              onFocusChange: (value) => context.read<ResumeProvider>().saveResume(resume),
              child: TextFormField(
                controller: _name,
                onChanged: (value) => controller.name.value = value,
                decoration: InputDecoration(
                  labelText: 'personal_info_screen.profile_name'.tr,
                  hintText: 'personal_info_screen.profile_name_tip'.tr,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _firstName,
              onChanged: (value) => controller.firstName.value = value,
              decoration: InputDecoration(
                labelText: 'personal_info_screen.first_name'.tr,
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _lastName,
              onChanged: (value) => controller.lastName.value = value,
              decoration: InputDecoration(
                labelText: 'personal_info_screen.last_name'.tr,
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: _telephone,
              onChanged: (value) => controller.telephone.value = value,
              decoration: InputDecoration(
                labelText: 'personal_info_screen.mobile'.tr,
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              onChanged: (value) => controller.email.value = value,
              decoration: InputDecoration(
                labelText: 'personal_info_screen.email'.tr,
              ),
            ),

            const SizedBox(height: 10,),
            TextFormField(
              controller: _location,
              onChanged: (value) => controller.location.value = value,
              decoration: InputDecoration(
                labelText: 'personal_info_screen.location'.tr,
              ),
            ),

            Stack(
              children: [
                FocusScope(
                  child: Focus(
                    onKey: _handleKeyPress,
                    child: Builder(
                      builder: (BuildContext context) {
                        final FocusNode focusNode = Focus.of(context);
                        final bool hasFocus = focusNode.hasFocus;
                        return GestureDetector(
                          onTap: () {
                            focusNode.requestFocus();
                            Get.to(() => const AddLanguageWidget());
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: width,
                            padding: const EdgeInsets.all(10),
                            height:60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: hasFocus? Colors.blueAccent: Colors.grey,
                                width: hasFocus?2:1
                              ),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: resume.languages.map((e) => Container(
                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  margin: const EdgeInsets.only(right: 5),
                                  child: Text(e.language!),
                                  decoration: BoxDecoration(
                                    color: _renderLanguageLevelButtonColor(e.level!),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                )).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Container(
                  color: Colors.white,
                  margin: const EdgeInsets.only(left:10, top: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Text('personal_info_screen.languages'.tr),
                ),
              ],
            ),

            const SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.url,
              controller: _linkedIn,
              onChanged: (value) => controller.linkedIn.value = value,
              decoration: InputDecoration(
                labelText: 'personal_info_screen.linkedin'.tr,
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.url,
              controller: _github,
              onChanged: (value) => controller.github.value = value,
              decoration: InputDecoration(
                labelText: 'personal_info_screen.github'.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
