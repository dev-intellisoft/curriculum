import 'package:curriculum/core/classes/resume.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalWidget extends StatefulWidget {
  Resume resume;
  PersonalWidget({
    Key? key,
    required this.resume
  }) : super(key: key);

  @override
  _PersonalWidget createState() => _PersonalWidget();
}

class _PersonalWidget extends State<PersonalWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : true,

      appBar: AppBar(
        title: const Text('Personal Information'),
        actions: [
          GestureDetector(
            onTap: () async {
              // var data = await resume.save();
              // print(data);
              print(widget.resume.toJson());
            },
            child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(Icons.save_rounded)
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(right: 15, left: 15),
        child: ListView(
          children: [
            TextFormField(
              onChanged: (value) {
                setState(() {
                  widget.resume.name = value;
                });
              },
              decoration: const InputDecoration(
                  labelText: 'Profile name',
                  hintText: 'Eg.: My English Resume'
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  widget.resume.firstName = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'First name',
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  widget.resume.lastName = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Last name',
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  widget.resume.telephone = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Telephone',
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  widget.resume.email = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'E-mail',
              ),
            ),

            const SizedBox(height: 10,),
            TextFormField(
              onChanged: (value) {
                widget.resume.location = value;
              },
              decoration: const InputDecoration(
                labelText: 'Location',
              ),
            ),



            const SizedBox(height: 10,),
            TextFormField(
              onChanged: (value) {
                widget.resume.linkedIn = value;
              },
              decoration: const InputDecoration(
                labelText: 'Linkedin',
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  widget.resume.github = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Github',
              ),
            ),
          ],
        ),
      ),
    );
  }

}
