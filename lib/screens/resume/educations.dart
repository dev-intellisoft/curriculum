import 'package:curriculum/core/classes/education.dart';
import 'package:curriculum/screens/resume/add_education.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/providers/resume_provider.dart';
import '../../widgets/my_alert.dart';
import 'package:get/get.dart';

class EducationsScreen extends StatefulWidget {
  const EducationsScreen({ Key? key }) : super(key: key);

  @override
  _EducationsScreen createState() => _EducationsScreen();
}

class _EducationsScreen extends State<EducationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('educations_screen.title'.tr),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => AddEducationWidget(education: Education(),)),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body:FutureBuilder(
        future: Provider.of<ResumeProvider>(context).loadEducations(),
        builder: (context, data) {
          return Consumer<ResumeProvider>(
            builder: (context, data, index) {
              List<Education> educations = data.getEducations() ?? [];
              if ( educations.isEmpty ) {
                return Center(
                  child: Text('educations_screen.not_found'.tr, style: const TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                );
              }
              return ListView.builder(
                itemCount: educations.length,
                itemBuilder: (context, index) {
                  int _days = 0;
                  int _years = 0;
                  int _month = 0;
                  if ( educations[index].end != null && educations[index].start != null ) {
                    _days = educations[index].end!.difference(educations[index].start!).inDays;
                  } else if ( educations[index].start != null ) {
                    DateTime _now = DateTime.now();
                    _days = _now.difference(educations[index].start!).inDays;
                  }
                  _years = _days ~/ 360;
                  _month = ((_days - (_years * 360)) / 30).ceil();
                  return Slidable(
                    key: const ValueKey(0),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (value) {},
                          backgroundColor: const Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.file_copy_outlined,
                          label: 'duplicate'.tr,
                        ),
                        SlidableAction(
                          onPressed: (value) async {
                            SharedPreferences _prefs = await SharedPreferences.getInstance();
                            bool dontAsk = _prefs.getBool('dont_ask')?? true;
                            if ( dontAsk ) {
                              context.read<ResumeProvider>().removeEducation(educations[index].id!);
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => MyAlert(
                                  name: educations[index].institution!,
                                  onCancel: () => Get.back(),
                                  onConfirm: () {
                                    context.read<ResumeProvider>().removeEducation(educations[index].id!);
                                    Get.back();
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
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.3),
                            width: 1
                          )
                        )
                      ),
                      child: ListTile(
                        onTap: () => Get.to(() => AddEducationWidget(education: educations[index],)),
                        key: const ValueKey(0),
                        title: Text('${educations[index].institution}'),
                        subtitle: Text('${educations[index].course}'),
                        trailing: Text(
                          ''
                          //todo fix this DateFormat
                            // '${_years > 0?'years'.tr(namedArgs: {'years':'$_years'}):''} ${_month > 0?'months'.tr(namedArgs: {'month':'$_month'}):''}'
                        ),
                      ),
                    )
                  );
                },
              );
            },
          );
        },
      )
    );

  }

}
