import 'package:curriculum/core/classes/experience.dart';
import 'package:curriculum/screens/resume/experiences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curriculum/core/providers/resume_provider.dart';
import 'package:get/get.dart';

class AddExperienceWidget extends StatefulWidget {
  Experience experience;
  AddExperienceWidget({ Key? key, required this.experience }) : super(key: key);

  @override
  _AddExperienceWidget createState() => _AddExperienceWidget();
}

class _AddExperienceWidget extends State<AddExperienceWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _company = TextEditingController(text: widget.experience.company);
    TextEditingController _title = TextEditingController(text: widget.experience.title);
    TextEditingController _location = TextEditingController(text: widget.experience.location);
    TextEditingController _description = TextEditingController(text: widget.experience.description);
    TextEditingController _keywords =  TextEditingController(text: widget.experience.keywords);
    TextEditingController _start = TextEditingController(
      text: ''
      //todo fix this DateFormat
        // text: widget.experience.start == null?'':DateFormat('dd/MM/yyyy').format(widget.experience.start!)
    );
    TextEditingController _end = TextEditingController(
      text: ''
      //todo fix this DateFormat
        // text:widget.experience.end == null? '': DateFormat('dd/MM/yyyy').format(widget.experience.end!)
    );

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('experiences_screen.add_experience.title'.tr),
          actions: [
            GestureDetector(
              onTap: () {
                context.read<ResumeProvider>().saveExperience(widget.experience);
                Navigator.pop(context, MaterialPageRoute(builder: (_) {
                  return const ExperiencesScreen();
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
                const SizedBox(height: 15,),
                TextFormField(
                  controller: _company,
                  onChanged: (value) {
                    widget.experience.company = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'experiences_screen.add_experience.company'.tr
                  ),
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: _title,
                  onChanged: (value) {
                    widget.experience.title = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'experiences_screen.add_experience.job_title'.tr
                  ),
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: _location,
                  onChanged: (value) {
                    widget.experience.location = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'experiences_screen.add_experience.location'.tr,
                    hintText: 'experiences_screen.add_experience.location_tip'.tr,
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
                            widget.experience.start = pickedDate;
                            //todo fix this DateFormat
                            _start.text = pickedDate.toString();
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
                            widget.experience.end = pickedDate;
                            setState(() {
                              //todo fix this DateFormat
                              // _end.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 15,),
                TextFormField(
                  controller: _description,
                  onChanged: (value) {
                    widget.experience.description = value;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'experiences_screen.add_experience.description'.tr,
                  ),
                ),

                const SizedBox(height: 15,),
                TextFormField(
                  controller: _keywords,
                  onChanged: (value) {
                    widget.experience.keywords = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'experiences_screen.add_experience.keywords'.tr,
                    hintText: 'experiences_screen.add_experience.keywords_hint'.tr,
                    helperText: 'experiences_screen.add_experience.keywords_helper'.tr
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
