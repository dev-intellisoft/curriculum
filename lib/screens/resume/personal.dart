import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/core/providers/resume_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalWidget extends StatefulWidget {
  const PersonalWidget({ Key? key, }) : super(key: key);

  @override
  _PersonalWidget createState() => _PersonalWidget();
}

class _PersonalWidget extends State<PersonalWidget> {
  @override
  Widget build(BuildContext context) {
    Resume resume = context.read<ResumeProvider>().getResume();
    TextEditingController _name = TextEditingController(text: resume.name);
    TextEditingController _firstName = TextEditingController(text: resume.firstName);
    TextEditingController _lastName = TextEditingController(text: resume.lastName);
    TextEditingController _telephone = TextEditingController(text: resume.telephone);
    TextEditingController _email = TextEditingController(text: resume.email);
    TextEditingController _location = TextEditingController(text: resume.location);
    TextEditingController _linkedIn = TextEditingController(text: resume.linkedIn);
    TextEditingController _github = TextEditingController(text: resume.github);

    return Scaffold(
      resizeToAvoidBottomInset : true,

      appBar: AppBar(
        title: const Text('Personal Information'),
        actions: [
          Consumer<ResumeProvider>(builder: (context, data, index) {
            String? _name = data.getResume().name;
            bool _disableSaveButton = _name == '' || _name == null;
            return GestureDetector(
              onTap: () {
                if ( _disableSaveButton ) {
                  return;
                }
                context.read<ResumeProvider>().saveResume(resume);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Row(
                    children:  [
                      Container(
                          margin: const EdgeInsets.only(right: 5),
                          child:const Icon(Icons.check_circle_outline, color: Colors.white,)
                      ),
                      const Text('Saved!', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  action: SnackBarAction(
                    label: '',
                    onPressed: () {},
                  ),
                ));
              },
              child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.save_rounded,
                    color: _disableSaveButton?Colors.grey:Colors.blueAccent,)
              ),
            );
          })

        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(right: 15, left: 15),
        child: ListView(
          children: [
            const SizedBox(height: 15,),
            Focus(
              onFocusChange: (value) {
                context.read<ResumeProvider>().saveResume(resume);
              },
              child: TextFormField(
                controller: _name,
                onChanged: (value) {
                  resume.name = value;
                },
                decoration: const InputDecoration(
                    labelText: 'Profile name',
                    hintText: 'Eg.: My English Resume'
                ),
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _firstName,
              onChanged: (value) {
                resume.firstName = value;
              },
              decoration: const InputDecoration(
                labelText: 'First name',
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _lastName,
              onChanged: (value) {
                resume.lastName = value;
              },
              decoration: const InputDecoration(
                labelText: 'Last name',
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _telephone,
              onChanged: (value) {
                resume.telephone = value;
              },
              decoration: const InputDecoration(
                labelText: 'Telephone',
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _email,
              onChanged: (value) {
                resume.email = value;
              },
              decoration: const InputDecoration(
                labelText: 'E-mail',
              ),
            ),

            const SizedBox(height: 10,),
            TextFormField(
              controller: _location,
              onChanged: (value) {
                resume.location = value;
              },
              decoration: const InputDecoration(
                labelText: 'Location',
              ),
            ),



            const SizedBox(height: 10,),
            TextFormField(
              controller: _linkedIn,
              onChanged: (value) {
                resume.linkedIn = value;
              },
              decoration: const InputDecoration(
                labelText: 'Linkedin',
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _github,
              onChanged: (value) {
                resume.github = value;
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
