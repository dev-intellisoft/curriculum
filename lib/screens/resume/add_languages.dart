import 'package:curriculum/screens/resume/personal.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../core/classes/language.dart';
import '../../core/providers/resume_provider.dart';
import '../../widgets/language_level.dart';
import 'package:provider/provider.dart';

class AddLanguageWidget extends StatefulWidget {
  const AddLanguageWidget({Key? key}) : super(key: key);

  @override
  _AddLanguageWidget createState() => _AddLanguageWidget();
}

class _AddLanguageWidget extends State<AddLanguageWidget> {
  String? language = '';

  Color _renderLanguageLevelButtonColor (String level) {
    switch (level) {
      case 'native':
        return Colors.green;
      case 'fluent':
        return Colors.greenAccent;
      case 'advanced':
        return Colors.orange;
      case 'intermediate':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _language = TextEditingController(text: language);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('personal_info_screen.add_languages.title'.tr()),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context, MaterialPageRoute(builder: (_) {
                  return const PersonalWidget();
                }));
              },
              child: Container(
                margin: const EdgeInsets.only(right: 15),
                child: const Icon(Icons.check),
              ),
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              TextFormField(
                controller: _language,
                onChanged: (value) {
                  language = value;
                },
                decoration: InputDecoration(
                  labelText: 'personal_info_screen.add_languages.label'.tr(),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if ( language == '' ) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('personal_info_screen.add_languages.warning'.tr(),),
                          backgroundColor: Colors.orange,
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        ));
                        return;
                      }
                      context.read<ResumeProvider>().addLanguage(Language(language:language, level: 'basic'));
                      setState(() {
                        language = '';
                      });
                    },
                    child: const Icon(Icons.add_circle),
                  )
                ),
              ),
              Expanded(
                child: Consumer<ResumeProvider>(
                  builder: (context, data, index) {
                    List<Language> languages = data.getResume().languages;
                    return ListView.builder(
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (value) {
                                  data.removeLanguageAt(index);
                                },
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'delete'.tr(),
                              ),
                            ]
                          ),
                          child: ListTile(
                            title: Text(languages[index].language!),
                            trailing: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context:context,
                                  builder:(_) => LanguageLevelWidget(
                                    language: languages[index],
                                    onSave: (Language lang) {
                                      data.updateLanguageAt(index, lang);
                                    }
                                  ),);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color:_renderLanguageLevelButtonColor(languages[index].level!),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Text('language_level.${languages[index].level}'.tr()),
                              ),
                            ),
                          )
                        );
                      });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
