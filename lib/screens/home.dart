import 'dart:async';

import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/main.dart';
import 'package:curriculum/screens/navigation.dart';
import 'package:curriculum/screens/previewer.dart';
import 'package:curriculum/widgets/my_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/providers/resume_provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidget createState() => _HomeWidget();
}

class _HomeWidget extends State<HomeWidget> {
  String cloneName = '';
  String username = 'Guest';

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
              showDialog(context: context, builder: (_) => AlertDialog(
                content: SizedBox(
                  height: 150,
                  child: Column(
                    children: [
                      Text('Username: $username'),
                      FlatButton(
                        minWidth: 200,
                          color: Colors.grey,
                          onPressed: () async {
                            SharedPreferences _prefs = await SharedPreferences.getInstance();
                            _prefs.clear();
                            Navigator.pop(_);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) =>
                                const MyApp()), (Route<dynamic> route) => false
                            );
                          },
                          child: const Text('Logout', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),)
                      ),
                      FlatButton(
                        minWidth: 200,
                        color: Colors.red,
                        onPressed: () {
                          showDialog(context: context, builder: (ctx) => AlertDialog(
                            title: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: const Icon(Icons.warning, color: Colors.orange,),
                                ),
                                const Text('Warning')
                              ],
                            ),
                            content: const Text('Are you sure you want to delete your account?'),
                            actions: [
                              FlatButton(
                                onPressed: () async {
                                  bool remove = await context.read<ResumeProvider>().removeAccount();
                                  if (remove) {
                                    Navigator.pop(ctx);
                                    Navigator.pop(_);
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) =>
                                        const MyApp()), (Route<dynamic> route) => false
                                    );
                                  }
                                },
                                child: const Text('Yes', style: TextStyle(
                                  color: Colors.white
                                ),),
                                color: Colors.red,
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No'),
                                color: Colors.grey.withOpacity(0.5),
                              )
                            ],
                          ),);
                        },
                        child: const Text('Delete my account', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),)
                      ),
                    ],
                  ),
                ),
              ));
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
                          label: 'Generate',
                        ),
                        SlidableAction(
                          onPressed: (value) {
                            showDialog(context: context, builder: (_) => AlertDialog(
                              title: Row(
                                children: const [
                                  Icon(Icons.file_copy_outlined),
                                  Text('Clone you cv as...')
                                ],
                              ),
                              content: TextFormField(
                                decoration: const InputDecoration(
                                  label: Text('Copy name')
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
                                  child: const Text('Cancel')
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
                                  child: const Text('Clone')
                                )
                              ],
                            ));
                          },
                          backgroundColor: const Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.file_copy_outlined,
                          label: 'Clone',
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
                          label: 'Delete',
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
