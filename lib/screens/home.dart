import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/screens/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../core/providers/resume_provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidget createState() => _HomeWidget();
}

class _HomeWidget extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const NavigationScreen();
              }));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
                child: const Icon(Icons.add_circle)
            ),
          )
        ],
      ),
        body: SafeArea(
          child: FutureBuilder(
            future: Provider.of<ResumeProvider>(context).loadResumes(),
            builder:  (BuildContext context, AsyncSnapshot<List<Resume>> snapShot) {
              if ( snapShot.data != null && !(snapShot.data!.length > 0) ) {
                return const Center(
                    child: Text('No resume found!', style: TextStyle(fontWeight: FontWeight.bold),)
                );
              }
              return Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: ListView.builder(
                  itemCount: snapShot.data == null?0:snapShot.data!.length,
                  itemBuilder: (context, i) {
                    return Slidable(
                        key: const ValueKey(0),
                        child: ListTile(
                          onTap: () {
                            context.read<ResumeProvider>().setResume(snapShot.data![i]);
                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                              return const NavigationScreen();
                            }));
                          },
                            title: Text(snapShot.data![i].name!)
                        ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        // dismissible: DismissiblePane(onDismissed: () {}),
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
                              context.read<ResumeProvider>().removeResume(snapShot.data![i].id!);
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),

                        ],
                      ),
                    );
                  },
                )
              );
            }
          )
        )
    );
  }

}
