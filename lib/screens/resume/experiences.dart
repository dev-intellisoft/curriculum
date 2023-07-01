import 'package:curriculum/core/classes/experience.dart';
import 'package:curriculum/core/resume.dart';
import 'package:curriculum/screens/resume/add_experience.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curriculum/core/providers/resume_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/my_alert.dart';
import 'package:get/get.dart';

class ExperiencesScreen extends StatefulWidget {
  const ExperiencesScreen({ Key? key }) : super(key: key);

  @override
  _ExperiencesScreen createState() => _ExperiencesScreen();
}

class _ExperiencesScreen extends State<ExperiencesScreen> {
  ResumeController controller = Get.find<ResumeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('experiences_screen.title'.tr),
        actions: [
          GestureDetector(
            onTap: ()  => Get.to(() => AddExperienceWidget(experience: Experience(),)),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ResumeProvider>(context).loadExperiences(),
        builder: (context, data) {
          return Consumer<ResumeProvider>(
            builder:(context, data, index) {
              List<Experience> experiences = data.getExperience() ?? [];
              if ( experiences.isEmpty ) {
                return Center(
                  child: Text('experiences_screen.not_found'.tr, style: const TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                );
              }

              return ListView.builder(
                itemCount: experiences.length,
                itemBuilder: (context, index) {
                  int _days = 0;
                  int _years = 0;
                  int _month = 0;
                  if ( experiences[index].end != null && experiences[index].start != null ) {
                    _days = experiences[index].end!.difference(experiences[index].start!).inDays;
                  } else if ( experiences[index].start != null ) {
                    DateTime _now = DateTime.now();
                    _days = _now.difference(experiences[index].start!).inDays;
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
                              context.read<ResumeProvider>().removeExperience(experiences[index].id!);
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => MyAlert(
                                  name: experiences[index].company!,
                                  onCancel: () => Get.back(),
                                  onConfirm: () {
                                    context.read<ResumeProvider>().removeExperience(experiences[index].id!);
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
                            color: Colors.grey.withOpacity(0.3), width: 1
                          )
                        )
                      ),
                      child: ListTile(
                        onTap: () => Get.to(() => AddExperienceWidget(experience: experiences[index],)),
                        key: const ValueKey(0),
                        title: Text('${experiences[index].company}'),
                        subtitle: Text('${experiences[index].title}'),
                        trailing: const Text(
                          '',
                          //todo fix this DateFormat
                            // '${_years > 0?'years'.tr(namedArgs: { 'years':'$_years' }):''} ${_month > 0?'months'.tr(namedArgs: {'month':'$_month'}):''}'
                        ),
                      ),
                    )
                  );
                },
              );
            }
          );
        },
      ),);
  }

}
