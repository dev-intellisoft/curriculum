import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidget createState() => _HomeWidget();
}

class _HomeWidget extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const ProfileWidget();
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
            future: Resume.getResumes(),
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
                    return ListTile(title: Text(snapShot.data![i].name!));
                  },
                )
              );
            }
          )
        )
    );
  }

}
