import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BiometricAlert extends StatefulWidget {
  Function onConfirm;
  Function onCancel;
  BiometricAlert({
    Key? key,
    required this.onConfirm,
    required this.onCancel
  }) : super(key: key);

  @override
  _BiometricAlert createState() => _BiometricAlert();
}

class _BiometricAlert extends State<BiometricAlert> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Icon(Icons.warning, color: Colors.orange,),
          ),
          Text('warning'.tr)
        ],
      ),
      content: SizedBox(
        height: 170,
        child: Column(
          children: [
            Text('biometric_alert.notice'.tr, style: const TextStyle(
              fontWeight: FontWeight.bold
            ), textAlign: TextAlign.center,),
            const SizedBox(height: 30,),
            const Icon(Icons.fingerprint, size: 80, color: Colors.blueAccent,)
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
              Get.back();
              widget.onConfirm.call();
          },
          child: Text('yes'.tr, style: const TextStyle(
              color: Colors.white
          ),),
          // color: Colors.green,
        ),
        TextButton(
          onPressed: () {
            Get.back();
            widget.onCancel.call();
          },
          child: Text('no'.tr),
          // color: Colors.grey.withOpacity(0.5),
        )
      ],
    );
  }

}
