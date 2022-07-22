import 'package:curriculum/core/providers/resume_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
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
        title: Text('settings_screen.about_screen.title'.tr()),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20,),
          const Divider(),
          ListTile(
            title:  Text('settings_screen.about_screen.app_name'.tr()),
            trailing: Text(appName, style: const TextStyle(
                fontWeight: FontWeight.bold
            ),),
          ),
          const Divider(),
          ListTile(
            title:  Text('settings_screen.about_screen.version'.tr()),
            trailing: Text(version, style: const TextStyle(
                fontWeight: FontWeight.bold
            ),),
          ),
          const Divider(),
          ListTile(
            title: Text('settings_screen.about_screen.build'.tr()),
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
                    Text('warning'.tr())
                  ],
                ),
                content: Text('delete_warning'.tr()),
                actions: [
                  FlatButton(
                    onPressed: () async {
                      bool remove = await context.read<ResumeProvider>().removeAccount();
                      if (remove) {
                        Navigator.pop(_);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) =>
                            const MyApp()), (Route<dynamic> route) => false
                        );
                      }
                    },
                    child: Text('yes'.tr()),
                    color: Colors.red,
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('no'.tr()),
                    color: Colors.grey.withOpacity(0.5),
                  )
                ],
              ),);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 47,
              alignment: Alignment.center,
              child: Text('delete_my_account'.tr(), style: const TextStyle(
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
