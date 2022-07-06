import 'package:curriculum/core/classes/experience.dart';
import 'package:curriculum/screens/resume/experiences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curriculum/core/providers/resume_provider.dart';

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
    TextEditingController _start = TextEditingController(text: widget.experience.start);
    TextEditingController _end = TextEditingController(text: widget.experience.end);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Experience'),
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
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _company,
                  onChanged: (value) {
                    widget.experience.company = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Company'
                  ),
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: _title,
                  onChanged: (value) {
                    widget.experience.title = value;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Job Title'
                  ),
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: _location,
                  onChanged: (value) {
                    widget.experience.location = value;
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
                            widget.experience.start = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                            _start.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
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
                            widget.experience.end = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                            setState(() {
                              _end.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 15,),
                TextFormField(
                  onChanged: (value) {
                    // widget.experience!.keywords = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Keywords',
                  ),
                ),

                const SizedBox(height: 15,),
                TextFormField(
                  controller: _description,
                  onChanged: (value) {
                    widget.experience.description = value;
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
