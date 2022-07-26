import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/core/providers/resume_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

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
        title: Text('personal_info_screen.title'.tr()),
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
                      Text('personal_info_screen.success'.tr(), style: const TextStyle(
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
                decoration: InputDecoration(
                    labelText: 'personal_info_screen.profile_name'.tr(),
                    hintText: 'personal_info_screen.profile_name_tip'.tr(),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _firstName,
              onChanged: (value) {
                resume.firstName = value;
              },
              decoration: InputDecoration(
                labelText: 'personal_info_screen.first_name'.tr(),
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _lastName,
              onChanged: (value) {
                resume.lastName = value;
              },
              decoration: InputDecoration(
                labelText: 'personal_info_screen.last_name'.tr(),
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: _telephone,
              onChanged: (value) {
                resume.telephone = value;
              },
              decoration: InputDecoration(
                labelText: 'personal_info_screen.mobile'.tr(),
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              onChanged: (value) {
                resume.email = value;
              },
              decoration: InputDecoration(
                labelText: 'personal_info_screen.email'.tr(),
              ),
            ),

            const SizedBox(height: 10,),
            TextFormField(
              controller: _location,
              onChanged: (value) {
                resume.location = value;
              },
              decoration: InputDecoration(
                labelText: 'personal_info_screen.location'.tr(),
              ),
            ),



            const SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.url,
              controller: _linkedIn,
              onChanged: (value) {
                resume.linkedIn = value;
              },
              decoration: InputDecoration(
                labelText: 'personal_info_screen.linkedin'.tr(),
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.url,
              controller: _github,
              onChanged: (value) {
                resume.github = value;
              },
              decoration: InputDecoration(
                labelText: 'personal_info_screen.github'.tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
