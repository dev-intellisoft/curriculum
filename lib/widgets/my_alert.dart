import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class MyAlert extends StatefulWidget {
  String name;
  Function onCancel;
  Function onConfirm;
  MyAlert({
    Key? key,
    required this.name,
    required this.onCancel,
    required this.onConfirm
  }) : super(key: key);

  @override
  _MyAlert createState() => _MyAlert();
}

class _MyAlert extends State<MyAlert> {
  bool dontAsk = false;

  void _init () async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      dontAsk = _prefs.getBool('dont_ask') ?? false;
    });
  }
  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Container(
            child: const Icon(Icons.warning, color: Colors.orange,),
            margin: const EdgeInsets.only(right: 15),
          ),
          Text('my_alert.warning'.tr())
        ],
      ),
      content: SizedBox(
        height: 86,
        child: Column(
          children: [
            Text('my_alert.notice'.tr(namedArgs: {'name':widget.name})),

            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  value: dontAsk,
                  onChanged: (bool? value) async {
                    if ( value != null ) {
                      setState(() {
                        dontAsk = value;
                      });
                    }
                    SharedPreferences _prefs = await SharedPreferences.getInstance();
                    await _prefs.setBool('dont_ask', dontAsk);
                  },
                ),
                const Text('Don\'t ask again!')
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => widget.onCancel.call(),
            child: Text('no'.tr())
        ),
        TextButton(
            onPressed: () => widget.onConfirm.call(),
            child: Text('yes'.tr())
        )
      ],
    );
  }

}
