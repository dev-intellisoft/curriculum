import 'package:curriculum/core/classes/education.dart';
import 'package:curriculum/screens/resume/educations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curriculum/core/providers/resume_provider.dart';
import 'package:get/get.dart';

class AddEducationWidget extends StatefulWidget {
  Education education;
  AddEducationWidget({ Key? key, required this.education }) : super(key: key);

  @override
  _AddEducationWidget createState() => _AddEducationWidget();
}

class _AddEducationWidget extends State<AddEducationWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _start = TextEditingController(
      text:''
      //todo fix this DateFormat
        // text: widget.education.start == null?'':DateFormat('dd/MM/yyyy').format(widget.education.start!)
    );
    TextEditingController _end = TextEditingController(
      text: ''
      //todo fix this DateFormat
        // text: widget.education.end == null?'':DateFormat('dd/MM/yyyy').format(widget.education.end!)
    );
    TextEditingController _institution = TextEditingController(text: widget.education.institution);
    TextEditingController _course = TextEditingController(text: widget.education.course);
    TextEditingController _location = TextEditingController(text: widget.education.location);
    TextEditingController _description = TextEditingController(text: widget.education.description);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('educations_screen.add_education.title'.tr),
          actions: [
            GestureDetector(
              onTap: () {
                context.read<ResumeProvider>().saveEducation(widget.education);
                Navigator.pop(context, MaterialPageRoute(builder: (_) {
                  return const EducationsScreen();
                }));
              },
              child: Container(
                margin: const EdgeInsets.only(right: 15),
                child: const Icon(Icons.check),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: ListView(
              children: [
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _institution,
                  onChanged: (value) {
                    widget.education.institution = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'educations_screen.add_education.institution'.tr
                  ),
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: _course,
                  onChanged: (value) {
                    widget.education.course = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'educations_screen.add_education.course'.tr
                  ),
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: _location,
                  onChanged: (value) {
                    widget.education.location = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'educations_screen.add_education.location'.tr,
                    hintText: 'educations_screen.add_education.location_tip'.tr,
                  ),
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      flex: 50,
                      child: TextFormField(
                        controller: _start,
                        decoration: InputDecoration(
                            labelText: 'start'.tr
                        ),
                        readOnly: true,  //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              initialDatePickerMode: DatePickerMode.year,
                              context: context, initialDate: DateTime.now(),
                              firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime.now()
                          );

                          if(pickedDate != null ){
                            widget.education.start = pickedDate;
                            _start.text = pickedDate.toString();
                            //todo fix this DateFormat
                            // _start.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 50,
                      child: TextFormField(
                        controller: _end,
                        decoration: InputDecoration(
                            labelText: 'end'.tr
                        ),
                        readOnly: true,  //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            initialDatePickerMode: DatePickerMode.year,
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now()
                          );

                          if(pickedDate != null ){
                            widget.education.end = pickedDate;
                            setState(() {
                              // _end.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: _description,
                  onChanged: (value) {
                    widget.education.description = value;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      labelText: 'educations_screen.add_education.description'.tr,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
