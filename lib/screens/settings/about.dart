import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';

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

        ],
      ),
    );
  }

}
