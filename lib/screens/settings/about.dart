import 'package:curriculum/core/providers/resume_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreen createState() => _AboutScreen();
}

class _AboutScreen extends State<AboutScreen> {
  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';

  void _init () async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20,),
          const Divider(),
          ListTile(
            title: const Text('App name: '),
            trailing: Text(appName, style: const TextStyle(
                fontWeight: FontWeight.bold
            ),),
          ),
          const Divider(),
          ListTile(
            title: const Text('Version: '),
            trailing: Text(version, style: const TextStyle(
                fontWeight: FontWeight.bold
            ),),
          ),
          const Divider(),
          ListTile(
            title: const Text('Build: '),
            trailing: Text(buildNumber, style: const TextStyle(
                fontWeight: FontWeight.bold
            ),),
          ),
          const Divider(),
          const SizedBox(height: 20,),

          GestureDetector(
            onTap: () {
              showDialog(context: context, builder: (_) => AlertDialog(
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                          return const MyApp();
                        }));
                      }
                    },
                    child: const Text('Yes'),
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
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 47,
              alignment: Alignment.center,
              child: const Text('Delete my account', style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5)
              ),
            ),
          )

        ],
      ),
    );
  }

}
