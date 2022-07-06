import 'package:curriculum/core/classes/experience.dart';
import 'package:curriculum/screens/resume/add_experience.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curriculum/core/providers/resume_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExperiencesWidget extends StatefulWidget {
  const ExperiencesWidget({ Key? key }) : super(key: key);

  @override
  _ExperiencesWidget createState() => _ExperiencesWidget();
}

class _ExperiencesWidget extends State<ExperiencesWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Experiences'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return AddExperienceWidget(experience: Experience(),);
              }));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body: Consumer<ResumeProvider>(
        builder:(context, data, index) {
          List<Experience> experiences = data.getExperience() ?? [];
          if ( experiences.isEmpty ) {
            return const Center(
              child: Text('No records found!', style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
            );
          }

          return ListView.builder(
            itemCount: experiences.length,
            itemBuilder: (context, index) {
              return Slidable(
                key: const ValueKey(0),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  children: [
                    SlidableAction(
                      onPressed: (value) {},
                      backgroundColor: const Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.file_copy_outlined,
                      label: 'Duplicate',
                    ),
                    SlidableAction(
                      onPressed: (value) {
                        context.read<ResumeProvider>().removeExperience(experiences[index].tempId!);
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),

                  ],
                ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return AddExperienceWidget(experience: experiences[index],);
                      }));
                    },
                  key: const ValueKey(0),
                  title: Text('${experiences[index].company}'),
                )
              );
            },
          );
      }
      ),
    );
  }

}