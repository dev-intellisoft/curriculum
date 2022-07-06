import 'package:curriculum/core/classes/education.dart';
import 'package:curriculum/screens/resume/add_education.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../core/providers/resume_provider.dart';

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
        title: const Text('Educations'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return AddEducationWidget(education: Education(),);
              }));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body:Consumer<ResumeProvider>(
        builder: (context, data, index) {
          List<Education> educations = data.getEducations() ?? [];
          if ( educations.isEmpty ) {
            return const Center(
              child: Text('No records found!', style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
            );
          }
          return ListView.builder(
            itemCount: educations.length,
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
                          context.read<ResumeProvider>().removeEducation(educations[index].tempId!);
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
                        return AddEducationWidget(education: educations[index],);
                      }));
                    },
                    key: const ValueKey(0),
                    title: Text('${educations[index].institution}'),
                  )
              );
            },
          );
        },
      )
    );

  }

}
