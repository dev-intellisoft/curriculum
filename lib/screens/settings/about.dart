import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('App name: '),
              Text(appName, style: const TextStyle(
                  fontWeight: FontWeight.bold
              ),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Version: '),
              Text(version, style: const TextStyle(
                  fontWeight: FontWeight.bold
              ),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Build: '),
              Text(buildNumber, style: const TextStyle(
                  fontWeight: FontWeight.bold
              ),),
            ],
          )
        ],
      ),
    );
  }

}
