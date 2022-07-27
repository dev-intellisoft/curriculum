import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/screens/navigation.dart';
import 'package:curriculum/screens/previewer.dart';
import 'package:curriculum/screens/resume/settings.dart';
import 'package:curriculum/widgets/my_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/providers/resume_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ResumesWidget extends StatefulWidget {
  const ResumesWidget({Key? key}) : super(key: key);

  @override
  _ResumesWidget createState() => _ResumesWidget();
}

class _ResumesWidget extends State<ResumesWidget> {
  String cloneName = '';
  String username = 'guest'.tr();

  void _init() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String  _username = _prefs.getString('username') ?? '';
    setState(() {
      username = _username;
    });
  }
  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : true,
      appBar: AppBar(
        leading: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) =>
              const SettingsScreen()));
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                shape: BoxShape.circle
              ),
              child: Center(
                child: Text(username[0].toUpperCase(), style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold
                ),),
              ),
            ),
          ),
        ),
        title: Text('resumes_screen.title'.tr()),
        actions: [
          GestureDetector(
            onTap: () async{
              context.read<ResumeProvider>().setResume(Resume(experiences: [], educations: [], languages: []));
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
                return Center(
                  child: Text('resumes_screen.not_found'.tr(), style: const TextStyle(fontWeight: FontWeight.bold),)
                );
              }
              return ListView.builder(
                itemCount: snapShot.data == null?0:snapShot.data!.length,
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
                        onTap: () {
                          context.read<ResumeProvider>().setResume(snapShot.data![i]);
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return const NavigationScreen();
                          }));
                        },
                        title: Text(snapShot.data![i].name!)
                      ),
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
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
                          label: 'resumes_screen.generate'.tr(),
                        ),
                        SlidableAction(
                          onPressed: (value) {
                            showDialog(context: context, builder: (_) => AlertDialog(
                              title: Row(
                                children: [
                                  const Icon(Icons.file_copy_outlined),
                                  Text('resumes_screen.clone_as'.tr())
                                ],
                              ),
                              content: TextFormField(
                                decoration: InputDecoration(
                                  label: Text('resumes_screen.copy_name'.tr())
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    cloneName = value;
                                  });
                                },
                              ),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('cancel'.tr())
                                ),
                                FlatButton(
                                  onPressed: () async {
                                    if (cloneName == '') {
                                      return;
                                    }
                                    await context.read<ResumeProvider>().cloneResume(snapShot.data![i].id, cloneName);
                                    setState(() {
                                      cloneName = '';
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text('clone'.tr())
                                )
                              ],
                            ));
                          },
                          backgroundColor: const Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.file_copy_outlined,
                          label: 'clone'.tr(),
                        ),
                        SlidableAction(
                          onPressed: (value) async {
                            SharedPreferences _prefs = await SharedPreferences.getInstance();
                            bool dontAsk = _prefs.getBool('dont_ask')?? true;
                            if ( dontAsk ) {
                              context.read<ResumeProvider>().removeResume(snapShot.data![i].id!);
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) => MyAlert(
                                  name: snapShot.data![i].name!,
                                  onCancel: () {
                                    Navigator.pop(context);
                                  },
                                  onConfirm: () {
                                    context.read<ResumeProvider>().removeResume(snapShot.data![i].id!);
                                    Navigator.pop(context);
                                  }
                                )
                              );
                            }
                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'delete'.tr(),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          )
        )
    );
  }
}
