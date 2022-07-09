import 'package:curriculum/core/classes/education.dart';
import 'package:curriculum/screens/resume/educations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:curriculum/core/providers/resume_provider.dart';

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
        text: widget.education.start == null?'':DateFormat('dd/MM/yyyy').format(widget.education.start!)
    );
    TextEditingController _end = TextEditingController(
        text: widget.education.end == null?'':DateFormat('dd/MM/yyyy').format(widget.education.end!)
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
          title: const Text('Add Education'),
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
                  decoration: const InputDecoration(
                    labelText: 'Institution'
                  ),
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: _course,
                  onChanged: (value) {
                    widget.education.course = value;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Course'
                  ),
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: _location,
                  onChanged: (value) {
                    widget.education.location = value;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Location',
                    hintText: 'London, UK'
                  ),
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      flex: 50,
                      child: TextFormField(
                        controller: _start,
                        decoration: const InputDecoration(
                            labelText: 'Start'
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
                            _start.text = DateFormat('dd/MM/yyyy').format(pickedDate);
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
                        decoration: const InputDecoration(
                            labelText: 'End'
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
                              _end.text = DateFormat('dd/MM/yyyy').format(pickedDate);
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
                  decoration: const InputDecoration(
                    labelText: 'Description',
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
