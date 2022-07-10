import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  _SupportScreen createState() => _SupportScreen();
}

class _SupportScreen extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: Column(
        children: const [
          Center(
            child: Text('wellington@intellisoft.net.br', style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
          ),

          Center(
            child: Text('In UAE: +971 52 4886', style: TextStyle(
                fontWeight: FontWeight.bold
            ),),
          ),

          Center(
            child: Text('Global: +971 52 4886 (WhatsApp)', style: TextStyle(
                fontWeight: FontWeight.bold
            ),),
          )
        ],
      ),
    );
  }

}
