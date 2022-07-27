import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/core/database_helper.dart';
import 'package:curriculum/core/pdf/sample.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PreviewerScreen extends StatefulWidget {
  int? resumeId;
  PreviewerScreen({
    Key? key,
    this.resumeId
  }) : super(key: key);

  @override
  _PreviewerScreen createState() => _PreviewerScreen();
}

class _PreviewerScreen extends State<PreviewerScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Resume'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: DatabaseHelper.instance.getPdfData(widget.resumeId!),
          initialData: Resume(educations: [], experiences: [], languages: []),
          builder: (context, AsyncSnapshot<Resume> snapshot) {
            return PdfPreview(
              previewPageMargin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(0),
              maxPageWidth: 700,
              build: (format) => samples[0].builder(format, snapshot.data),
              actions: [],
            );
          },
        ),
      ),
    );
  }

}
