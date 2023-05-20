import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/core/resume.dart';
import 'package:curriculum/screens/navigation.dart';
import 'package:curriculum/screens/previewer.dart';
import 'package:curriculum/screens/resume/settings.dart';
import 'package:curriculum/widgets/base_app_bar.dart';
import 'package:curriculum/widgets/my_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/providers/resume_provider.dart';
import 'package:get/get.dart';

class ResumesWidget extends StatefulWidget {
  const ResumesWidget({Key? key}) : super(key: key);

  @override
  _ResumesWidget createState() => _ResumesWidget();
}

class _ResumesWidget extends State<ResumesWidget> {

  ResumeController controller = Get.find<ResumeController>();

  String cloneName = '';

  @override
  void initState() {
    super.initState();
  }

  _showAlert(int resumeId) {
    String cloneName = '';
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.file_copy_outlined),
          Text('resumes_screen.clone_as'.tr)
        ],
      ),
      content: TextFormField(
        decoration: InputDecoration(
            label: Text('resumes_screen.copy_name'.tr)
        ),
        onChanged: (value) => cloneName = value,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('cancel'.tr)
        ),
        TextButton(
          onPressed: () => controller.cloneResume(resumeId, cloneName),
            child: Text('clone'.tr)
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.loadResumes();
    return Scaffold(
      resizeToAvoidBottomInset : true,
      appBar: BaseAppBar(),
      body: SafeArea(
      child: Obx(()  {
        if (controller.resumes.isNotEmpty) {
          return ListView.builder(
            itemCount: controller.resumes.length,
            itemBuilder: (context, i) {
              return Slidable(
                key: const ValueKey(0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1
                      )
                    )
                  ),
                  child: ListTile(
                    onTap: () => controller.gotToResume(i),
                      title: Text(controller.resumes[i].name!)
                  ),
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (value) => Get.to(() =>
                          PreviewerScreen(resumeId:controller.resumes[i].id, name:controller.resumes[i].name! ,)
                      ),
                      backgroundColor: const Color(0xFF18A100),
                      foregroundColor: Colors.white,
                      icon: Icons.picture_as_pdf,
                      label: 'resumes_screen.generate'.tr,
                    ),
                    SlidableAction(
                      onPressed: (value) => showDialog(context: context, builder: (_) => _showAlert(controller.resumes[i].id)),
                      backgroundColor: const Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.file_copy_outlined,
                      label: 'clone'.tr,
                    ),
                    SlidableAction(
                      onPressed: (value) async {
                        SharedPreferences _prefs = await SharedPreferences.getInstance();
                        bool dontAsk = _prefs.getBool('dont_ask')?? true;
                        if ( dontAsk ) {
                          context.read<ResumeProvider>().removeResume(controller.resumes[i].id!);
                        } else {
                          showDialog(
                              context: context,
                              builder: (_) => MyAlert(
                                  name: controller.resumes[i].name!,
                                  onCancel: () => Navigator.pop(context),
                                  onConfirm: () {
                                    context.read<ResumeProvider>().removeResume(controller.resumes[i].id!);
                                    Navigator.pop(context);
                                  }
                              )
                          );
                        }
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'delete'.tr,
                    ),
                  ],
                ),
              );
            },
          );
        }
        return Center(
            child: Text('resumes_screen.not_found'.tr, style: const TextStyle(fontWeight: FontWeight.bold),)
        );
      }),
    )
    );
  }
}
