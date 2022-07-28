import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../core/classes/language.dart';

class LanguageLevelWidget extends StatefulWidget {
  Language language;
  Function onSave;

  LanguageLevelWidget({
    Key? key,
    required this.language,
    required this.onSave
  }) : super(key: key);

  @override
  _LanguageLevelWidget createState() => _LanguageLevelWidget();
}

class _LanguageLevelWidget extends State<LanguageLevelWidget> {
  Widget _renderButton({required String label, required Color color, Function? onTap, bool selected = false}) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
        widget.onSave.call(widget.language);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        child: Text(label, textAlign: TextAlign.center, style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),),
        decoration: BoxDecoration(
            color: color.withOpacity(selected?1:0.1),
            borderRadius: BorderRadius.circular(7)
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 290,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(widget.language.language!, style: const TextStyle(
                  fontWeight: FontWeight.bold,
                fontSize: 18
              ),),
            ),
            _renderButton(
              onTap: () {
                setState(() {
                  widget.language.level = 'native';
                });
                Navigator.pop(context);
              },
              label: 'language_level.native'.tr(),
              color: Colors.green,
              selected: 'native' == widget.language.level
            ),
            _renderButton(
              onTap: () {
                setState(() {
                  widget.language.level = 'fluent';
                });
                Navigator.pop(context);
              },
              label: 'language_level.fluent'.tr(),
              color: Colors.greenAccent,
              selected: 'fluent' == widget.language.level
            ),
            _renderButton(
              onTap: () {
                setState(() {
                  widget.language.level = 'advanced';
                });
                Navigator.pop(context);
              },
              label: 'language_level.advanced'.tr(),
              color: Colors.orange,
              selected: 'advanced' == widget.language.level
            ),
            _renderButton(
              onTap: () {
                setState(() {
                  widget.language.level = 'intermediate';
                });
                Navigator.pop(context);
              },
              label: 'language_level.intermediate'.tr(),
              color: Colors.yellow,
              selected: 'intermediate' == widget.language.level
            ),
            _renderButton(
              onTap: () {
                setState(() {
                  widget.language.level = 'basic';
                });
                Navigator.pop(context);
              },
              label: 'language_level.basic'.tr(),
              color: Colors.grey,
              selected: 'basic' == widget.language.level
            ),
          ],
        ),
      ),
    );
  }

}
