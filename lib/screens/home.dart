import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/screens/navigation.dart';
import 'package:curriculum/screens/previewer.dart';
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
  FocusNode focusNode = FocusNode();
  String cloneName = '';


  @override
  void dispose() {
    focusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : true,
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
                            onPressed: (value) async {
                              Navigator.push(context, MaterialPageRoute(builder: (_) {
                                return PreviewerScreen(resumeId:snapShot.data![i].id);
                              }));
                            },
                            backgroundColor: const Color(0xFF18A100),
                            foregroundColor: Colors.white,
                            icon: Icons.picture_as_pdf,
                            label: 'Generate',
                          ),
                          SlidableAction(
                            onPressed: (value) {
                              showModalBottomSheet(context: context, builder: (context) {
                                return Container(
                                  color: Colors.white,
                                  child: ListView(
                                    children: [
                                      Container(
                                        child: const Text('Clone my resume', style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),),
                                        margin: const EdgeInsets.only(left: 30, top: 30, right: 30),
                                      ),
                                      Container(
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              label: Text('Clone name')
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              cloneName = value;
                                            });
                                          },
                                          focusNode: focusNode,
                                          autofocus: true,
                                          onEditingComplete: () async {
                                            if (cloneName == '') {
                                              return;
                                            }

                                            await context.read<ResumeProvider>().cloneResume(snapShot.data![i].id, cloneName);
                                            setState(() {
                                              cloneName = '';
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),
                                        margin: const EdgeInsets.all(30),
                                      )
                                    ],
                                  ),
                                );
                              });
                              // focusNode.requestFocus();
                            },
                            backgroundColor: const Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.file_copy_outlined,
                            label: 'Clone',
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
